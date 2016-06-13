require 'webrick'
require 'json'
 
include WEBrick
 
def start_webrick(config = {})
  config.update(:Port => 9955)     
  server = HTTPServer.new(config)
  yield server if block_given?
  ['INT', 'TERM'].each {|signal| 
    trap(signal) {server.shutdown}
  }
  server.start
end
 
class RestServlet < HTTPServlet::AbstractServlet
    

    
  def do_POST(req,resp)
      # Split the path into pieces, getting rid of the first slash
      path = req.path[1..-1].split('/')
      raise HTTPStatus::NotFound if !RestServiceModule.const_defined?(path[0])
      response_class = RestServiceModule.const_get(path[0])
       
      if response_class and response_class.is_a?(Class)
        # There was a method given
        if path[1]
          response_method = path[1].to_sym
          # Make sure the method exists in the class
          raise HTTPStatus::NotFound if !response_class.respond_to?(response_method)
          # Remaining path segments get passed in as arguments to the method

          resp.body = response_class.send(response_method, req)

          raise HTTPStatus::OK
        # No method was given, so check for an "index" method instead
        else
          raise HTTPStatus::NotFound if !response_class.respond_to?(:index)
          resp.body = response_class.send(:index)
          raise HTTPStatus::OK
        end
      else
        raise HTTPStatus::NotFound
      end
  end
end
 
module RestServiceModule
  class AuthService
  
    def self.login(request)
      puts request.body
      bodyJson = JSON.parse(request.body)
      
      username = bodyJson["username"]
      password = bodyJson["password"]
      if username == "juani" and password == "123"
      return JSON.generate({:username => username, :name => "Juan"})
      else
        code = 1
        return JSON.generate({:errorCode => "#{code}"})
      end
      

    end
  end
end
 
start_webrick { | server |
  server.mount('/', RestServlet)
}


