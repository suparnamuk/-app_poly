class ApiController < ApplicationController
	class PolyController < ApiController
		def index
            @enter = enter.all
          render json: @enter.to_json
  end
  
  end
end
