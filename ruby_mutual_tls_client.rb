###########################
# This script assumes your access end point is protected with mutual TLS authentication, solution implemented here uses public and private key to authenticate
# end point & retrive the access token
#
###################################### 




require 'rest_client'
require 'JSON'

#Configure your Public and private certificate.
PUBLIC_CERT = OpenSSL::X509::Certificate.new(File.read('public.cer'))
PRIVATE_KEY = OpenSSL::PKey::RSA.new(File.read('private.pem'))


OAUTH_CREDENTIALS = {}


#Access token URL
@access_token_url = "domain.com/auth/oauth/v2/token"


#retrive access token from end point
def get_access_token
		response = RestClient::Request.execute(
			method: 'post',
			url: @access_token_url,
			payload: {
				grant_type: 'client_credentials',
				client_id: OAUTH_CREDENTIALS[:client_id],
				client_secret: OAUTH_CREDENTIALS[:client_secret],
				scope: 'oob'
			},
			ssl_client_cert: PUBLIC_CERT,
			ssl_client_key: PRIVATE_KEY
		)
		p JSON.parse(response)["access_token"]
end


get_access_token()