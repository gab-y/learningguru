class DriveFileController < ApplicationController
  require 'google/api_client'
  require 'google_drive'

  def open
  	#From params[:fileId] gets the content of this file, and update the app data
  	state = MultiJson.decode(params[:state] || '{}')
  	client = Google::APIClient.new(
  		application_name: 'Learning Guru',
  		application_version: '0.0.1'
  	)
  	auth = client.authorization

  	#https://developers.google.com/accounts/docs/OpenIDConnect#exchangecode 
  	auth.code = params[:code]
  	auth.client_id = '43268607343-a7ob6jf2aq4sn20n6tee4vkcra1iara7.apps.googleusercontent.com'
  	auth.client_secret = 'MZTa2NhRx05KmK2cTgDHj8Wp'
  	auth.redirect_uri = 'https://obscure-refuge-6806.herokuapp.com/drive_file/open'
  	auth.grant_type = 'authorization_code'

  	auth.fetch_access_token!
  	#drive = client.discovered_api('drive', 'v2')
  	session = GoogleDrive.login_with_oauth(auth.access_token)

  	if state['action'] == 'open'
  		#result = client.execute(
  		#	api_method: drive.files.get,
  		#	parameters: {fileId: state['ids'][0]}
  		#)
  		@file = session.file_by_id(state['exportIds'][0])
  	end
  end
end
