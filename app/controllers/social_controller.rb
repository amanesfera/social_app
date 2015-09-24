class SocialController < ApplicationController
  before_action :authenticate_user!
  def app
  end
def google_token_time
  require 'net/http'
  access_token="ya29.9wG45WceHPQ7C1HJ8omoCIsT2FobyVeZF9lj6WRpYAEx6RD50FH5X4xmwe3rU-un5GQj"
url = "https://www.googleapis.com/oauth2/v1/tokeninfo?access_token="+access_token
# ab=Net::HTTP::Get.new(url)
result = Net::HTTP.get(URI.parse(url))
render :plain => result
end


 def google_post(accesstoken,uid)
    puts 'google postttttttttttttttttt'
    if @url=='nill'
    myarray=
    {
    :object=> {
    :originalContent=> @description,
    },
    :access=> {
    :items=> [{
    :type=> "domain"
    }],
    :domainRestricted=> true
    }
    }
    json_string = myarray.to_json()
    post_url='https://www.googleapis.com/plusDomains/v1/people/'+uid+'/activities?access_token='+accesstoken
      c = Curl::Easy.http_post(post_url, json_string 
      ) do |curl|
      curl.headers['Accept'] = 'application/json'
      curl.headers['Content-Type'] = 'application/json'
      curl.headers['Api-Version'] = '2.2'
      end
    else # url nil
    image=@url_absolute
    cmd = 'curl --header "Authorization: OAuth '+accesstoken+'"'; 
    cmd += ' --header "Content-Type: image/jpeg"'; 
    cmd += ' --data-binary "@'+image+'"'; 
    cmd += ' -X POST https://www.googleapis.com/upload/plusDomains/v1/people/me/media/cloud';
    result=`#{cmd}`
    results=JSON.parse(result)
    url="https://www.googleapis.com/plusDomains/v1/people/"+uid+"/activities?access_token="+accesstoken
    media_array={
      :object => {
      :content => @description,
        :attachments => [ {
        :objectType => "photo",
        :id =>  results['id'],
        } ]
      },
      :access => {
        :items => [ {
        :type => "domain"
        } ],
        :domainRestricted => true
      }
    }
    json_string = media_array.to_json()
      c = Curl::Easy.http_post(url,json_string
      ) do |curl|
      curl.headers['Accept'] = 'text/json'
      curl.headers['Content-Type'] = 'application/json'
      curl.headers['Api-Version'] = '2.2'
      end
      puts c.body_str
    end #url nil
  rescue Exception => e
         my_logger.info("google error #{e.message} with accesstoken=#{accesstoken}")
  end
  

def refresh_token
  data = {
    :client_id => GOOGLE_KEY,
    :client_secret => GOOGLE_SECRET,
    :refresh_token => REFRESH_TOKEN,
    :grant_type => "refresh_token"
  }
  @response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
  if @response["access_token"].present?
    # Save your token
  else
    # No Token
  end
rescue RestClient::BadRequest => e
  # Bad request
rescue
  # Something else bad happened
end



def to_params
    {'refresh_token' => "1/rhLRC_gAtUerufCMqjAgLBVQc9DnkV2flcawJ-aMlqrBactUREZofsF9C7PrpE-j",
    'client_id' => ENV["GOOGLE_CLIENT_ID"],
    'client_secret' => ENV["GOOGLE_CLIENT_SECRET"],
    'grant_type' => 'refresh_token'}
  end

  def request_token_from_google
    url = URI("https://accounts.google.com/o/oauth2/token")
    response= Net::HTTP.post_form(url, self.to_params)
    data = JSON.parse(response.body)
    render :plain => data.inspect
  end



  
end
