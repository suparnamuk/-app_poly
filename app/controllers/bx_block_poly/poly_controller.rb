module BxBlockPoly
    class PolyController < ApplicationController
        
       
         def call
            
           



             url = URI.parse("https://echannel.insurancearticlez.com/epartners3.1/api/Cyber/policy")


           http = Net::HTTP.new(url.host, url.port)
           http.use_ssl = true
           request = Net::HTTP::Post.new(url)
           request['Content-Type'] = "application/json"

 request['Authorization'] =  "Bearer eyJhbGciOiJIUzM4NCIsInR5cCI6IkpXVCJ9.eyJqdGkiOiI2M2NmMjRiYS05Yjc3LTQ4ZmItODI3MC05YmIzNmU0MGFkODMiLCJSb2xlIjoiMCIsIkNsaWVudCI6IjE0NSIsIkNDSWQiOiIwIiwiSXNHdWVzdCI6IkZhbHNlIiwiU2Vzc2lvbklkIjoiYzJhMTM2OTktYWRlNy00ZDcwLWExZTAtYTVmMDUyMzAxMWUzIiwiU0tleSI6IjI4NTIyNjAzMjAyNjI1NzQ2ODE5MzYyNTc0NjYzMDU5IiwiU1AiOiJhQjlzcnRCdW1jbWtOZ0VsQ1M0MTYvNFoyR0MzcGYvYllYbnM5R3F2VkdIYzh5aGlTc0FaRnFBR1VQenBJNXpuYnQyZ2V4bENkYW1TZWdvbmloNGFMVlViK1pqYnRjeUJ3aFJzdytYRjVCR3QyLzgwY0oxOWl1WmFBbW9EWkJjcmdjRUFhd2NiVDFXZEpJbUMxVEhTc1BtWEFOcUM2SGhTY2g4Q2JqM1FmaktZQ2FuTGZvTXZiZzZ6MzRvQm1BYW8iLCJleHAiOjE2NTI0MTIzODEsImlzcyI6Imh0dHBzOi8vaWNpY2lsb21iYXJkLmNvbS9lQ2hhbm5lbC5QYXJ0bmVyU2VydmljZXMiLCJhdWQiOiJodHRwczovL3d3dy5pY2ljaWxvbWJhcmQuY29tL3BhcnRuZXJzIn0.5ZR6MKd4Iasai1eT8RSBf8z54Rg377beCYfEp6poj04QihCmnJ1UmQw8Io2HeE95"

           request.body = JSON(body)
           response = http.request(request)
           JSON(response.read body)
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