class BackendController < ApplicationController
  web_service_scaffold 'invoke'
  web_service_dispatching_mode :layered 
  web_service :blogger, BloggerService.new  
end
