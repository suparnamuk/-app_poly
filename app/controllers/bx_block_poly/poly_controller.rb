module BxBlockPoly
    class PolyController < ApplicationController
       require 'net/http'  
      require 'uri'
      require 'json'
       
         def call
@token =  "eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJmOGYxM2E5NS03YzBmLTQ3NDItOWYwMi03MDkzNzNiYzQwYWUiLCJSb2xlIjoiMCIsIkNsaWVudCI6IjE0NSIsIkNDSWQiOiIwIiwiSXNHdWVzdCI6IkZhbHNlIiwiU2Vzc2lvbklkIjoiMTlhMTMwMzctY2ZmNi00NzE2LTgxYzYtZTg3MmFjYjhiMjBhIiwiU0tleSI6IjE1NTcxMTI4NjYyNjcyNDE4ODU3Njc5NjIxNDY5NDE2IiwiU1AiOiJhQjlzcnRCdW1jbWtOZ0VsQ1M0MTYvNFoyR0MzcGYvYllYbnM5R3F2VkdIYzh5aGlTc0FaRnFBR1VQenBJNXpuYnQyZ2V4bENkYW1TZWdvbmloNGFMVlViK1pqYnRjeUJ3aFJzdytYRjVCR3QyLzgwY0oxOWl1WmFBbW9EWkJjcmdjRUFhd2NiVDFXZEpJbUMxVEhTc1BtWEFOcUM2SGhTY2g4Q2JqM1FmaktZQ2FuTGZvTXZiZzZ6MzRvQm1BYW8iLCJleHAiOjE2NTI1NTAyODYsImlzcyI6Imh0dHBzOi8vaWNpY2lsb21iYXJkLmNvbS9lQ2hhbm5lbC5QYXJ0bmVyU2VydmljZXMiLCJhdWQiOiJodHRwczovL3d3dy5pY2ljaWxvbWJhcmQuY29tL3BhcnRuZXJzIn0.iX_9urF8UHtQwSm9wW5Ia2CbIclpqjrmmUlzpBXMD7qyjVZmm0u2_j4j0g04PKy7"
           
            


              uri = URI.parse('https://echannel.insurancearticlez.com/epartners3.1/api/Cyber/policy')

              http = Net::HTTP.new(uri.host, uri.port)
             http.use_ssl = true
             req_options = {
               use_ssl: uri.scheme == "https",
              }
              req = Net::HTTP::Post.new(uri.request_uri)

              req['Content-Type'] = "application/json"
              req.headers['Authorization'] = "Bearer #{@token}"
              req.body = JSON(body) 
           # request['Authorization'] = tokenGenerated
           # request.headers('Authorization:','Bearer '+ tokenGenerated)

                 response = Net::HTTP.start(uri.hostname, uri.port,req_options) do |http|
                    http.request(req)

                 end

               JSON(response.read_body)
        
          
          end 
       
       def body 
        {
           "ClientReferenceNo": "POLMBK9AG9AI5410",
           "title": "Mr",
           "name": "xyz Kumar",
           "gender": "Male",
             "phoneNo": "9999999999",
            "emailId": "abc@xyz.com",
          "sumInsured": 50000,
          "bookedOn": "06-Feb-2022",
          "address": "India",
          "pinCode": "851203",
          "cityDistrict": "NA"
        }
      end 
           
         def poly_url
           
               render json: PolyController.new.call
               
          end
  
 


      
   end
   
  end