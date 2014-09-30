public with sharing class HTML5Controller {

    public string agent {get; set;}
    public string device {get; set;}
    public Map<String, String> pageParameters {get; set;}
    public List<String> paramValues {get; set;}
    public boolean isAndroid_3_2_Tablet {get; set;}
    public boolean isAndroid_2_3_6_Phone {get; set;}

    public HTML5Controller() {
    	agent = System.currentPageReference().getHeaders().get('User-Agent');
    	pageParameters = System.currentPageReference().getHeaders();
    	paramValues = System.currentPageReference().getHeaders().values();    	
    	//isAndroid_3_2_Tablet = agent.contains('Android 3.2') && agent.contains('Tablet') ? true : false;
    	//isAndroid_2_3_6_Phone = agent.contains('Android 2.3.6') && agent.contains('Mobile') ? true : false;
    	isAndroid_3_2_Tablet = agent.contains('Android 3.0') && agent.contains('HONEYCOMB') ? true : false;
    	isAndroid_2_3_6_Phone = agent.contains('Android 4.1.2') && agent.contains('Mobile') ? true : false;    	
    	
    }

    public PageReference detectDevice() {
    	if (isAndroid_3_2_Tablet) {
    		return Page.Android_3_2_Tablet.setRedirect(true);
    	}
    	else if (isAndroid_2_3_6_Phone) {
    		return Page.Android_2_3_6_Phone.setRedirect(true);
    	}
    	else {
    		return null;
    	}
    }
}