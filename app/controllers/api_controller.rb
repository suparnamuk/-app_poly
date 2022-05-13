class ApiController < ApplicationController
	class PolyController < ApiController
		def index
            @poly = poly.all
          render json: @poly.to_json
  end
  
  end
end
