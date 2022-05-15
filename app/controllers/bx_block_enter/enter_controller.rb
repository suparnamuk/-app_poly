module BxBlockEnter
	class EnterController < ApplicationController
	    require 'net/http'	
	    require 'uri'
	    require 'json'
		
		def call
            uri = URI.parse('https://echannel.insurancearticlez.com/epartners3.1/api/Auth/token')

            http = Net::HTTP.new(uri.host, uri.port)
             http.use_ssl = true
             req_options = {
               use_ssl: uri.scheme == "https",
              }
              req = Net::HTTP::Post.new(uri.request_uri)

              req['Content-Type'] = "application/json"

               req.body = JSON(body) 
                        
                
                
                response = Net::HTTP.start(uri.hostname, uri.port,req_options) do |http|
                    http.request(req)

                 end

               JSON(response.read_body)
              # render :json => response.body 
	    end

	    def body
	    	{
              "Login": "netambit",
              "Password": "Netambit",
              "LoginType": "App"
             }
        end


         def enter_url
           
               render json: EnterController.new.call
               
          end
	
	
	end
end