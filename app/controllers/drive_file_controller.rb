class DriveFileController < ApplicationController
  require 'google/api_client'
  require 'google_drive'

  def open
  	#From params[:fileId] gets the content of this file, and update the app data
  	state = MultiJson.decode(params[:state] || '{}')
  	client = Google::APIClient.new
  	client.application_name = 'Learning Guru'
  	client.application_version = '0.0.1'
  	#client.code = params[:code]
  	client.fetch_access_token!
  	#drive = client.discovered_api('drive', 'v2')
  	session = GoogleDrive.login_with_auth(client.access_token)

  	if state['action'] == 'open'
  		#result = client.execute(
  		#	api_method: drive.files.get,
  		#	parameters: {fileId: state['ids'][0]}
  		#)
  		file = session.file_by_id(state['ids'][0])
  	end
  end
end
