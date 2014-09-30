public with sharing class LinkedInController {
    final String redirect_uri = 'https%3A//c.na10.visual.force.com/apex/LinkedIn';
    final String scope = 'r_fullprofile%20r_emailaddress%20r_network';
    final String state = 'asjasjdj32423j324k23j2323jk23j';

    final String client_id = '4dafkkrprv2u';
    final String client_secret = 'yuvRhkPmPGDQBBNx';

    String code;
    String accessTokenURI;
    public String accessToken {get; set;}    
    public String body{get;set;}
    public String bodyProfile {get;set;}
    public String profileInfo {get;set;}
    public String authorizationCodeURI{get;set;}
    
    public LinkedInController()
    {
        code = ApexPages.currentPage().getParameters().get('code');
        authorizationCodeURI = 'https://www.linkedin.com/uas/oauth2/authorization?response_type=code'+
                               '&client_id='+client_id+
                               '&state='+state+
                               '&redirect_uri='+redirect_uri;//+
      //                         '&scope=' + scope;
        if(code <> null)
        {
            accessTokenURI = 'https://www.linkedin.com/uas/oauth2/accessToken?grant_type=authorization_code'+
                                           '&code=' + code +
                                           '&redirect_uri='+redirect_uri+
                                           '&client_id=' + client_id +
                                           '&client_secret=' + client_secret;
            HttpRequest req = new HttpRequest();
            req.setEndpoint(accessTokenURI);
            req.setMethod('POST');
            Http http = new Http();
            HTTPResponse res = http.send(req);
            body = res.getBody();
            accessToken = body.substring(body.indexOf('access_token":"')+15, body.length()-2);

            //String profileAPI = 'https://api.linkedin.com/v1/people/~:(id,first-name,last-name,headline,maiden-name,picture-url,formatted-name,phonetic-last-name,summary,location:(name,country:(code)),industry,distance,num-recommenders,current-status,current-share,network,skills,phone-numbers,specialties,date-of-birth,main-address,positions,email-address,educations:(school-name,field-of-study,start-date,end-date,degree,activities))?oauth2_access_token=' + accessToken;
            //String profileAPI = 'https://api.linkedin.com/v1/people/id=YA41tjhwJ0?oauth2_access_token=' + accessToken;
            String profileAPI = 'https://api.linkedin.com/v1/people/url=http%3a%2f%2fwww.linkedin.com%2fpub%2fsven-van-dijk%2f47%2f827%2faa:(id)?oauth2_access_token=' + accessToken;
            //String profileAPI = 'https://api.linkedin.com/v1/people/id=c4Og8Roddh:(id,first-name,last-name,headline,maiden-name,picture-url,formatted-name,phonetic-last-name,summary,location:(name,country:(code)),industry,distance,num-recommenders,current-status,current-share,network,skills,phone-numbers,specialties,date-of-birth,main-address,positions,email-address,educations:(school-name,field-of-study,start-date,end-date,degree,activities))?oauth2_access_token=' + accessToken;
            //String profileAPI = 'http://www.linkedin.com/x/profile/4dafkkrprv2u/166273474';
            req = new HttpRequest();
            req.setEndpoint(profileAPI);
            req.setMethod('GET');
            http = new Http();
            res = http.send(req);
            bodyProfile = res.getBody();
            
            Xmlstreamreader reader = new Xmlstreamreader(bodyProfile);
            // http://developer.linkedin.com/documents/profile-api

            
        }
    }
}