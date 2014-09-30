public with sharing class RegisterController {

   Contact contact;
   User user;
   private static Id PORTAL_ACCOUNT_ID = '001A000000QPSbJ';

   public String firstname {get; set;}
   public String lastname {get; set;}
   public String username {get; set;}
   public String email {get; set;}
   public String password {get; set {password = value == null ? value : value.trim(); } }
   public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }  
   private String[] selectedAudioVideoMultimedia = new String[]{};
   private String[] selectedGraphicDesign = new String[]{};
   private String[] selectedSoftwareProgramming = new String[]{};
   private String[] selectedWebDevelopment = new String[]{};
   
   public RegisterController () {
   }

   private boolean isValidPassword() {
      return password == confirmPassword;
   }

   public List<SelectOption> getAudioVideoMultimediaOptions() {
      List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('Animation','Animation'));
      options.add(new SelectOption('Music','Music'));
      options.add(new SelectOption('Other','Other'));
      options.add(new SelectOption('Streaming Audio and Video','Streaming Audio and Video'));
      options.add(new SelectOption('Video Editing','Video Editing'));
      return options;
   }
   
   public List<SelectOption> getGraphicDesignOptions() {
      List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('3D Graphics','3D Graphics'));
      options.add(new SelectOption('Animation','Animation'));
      options.add(new SelectOption('Banner / Logo Design','Banner / Logo Design'));
      options.add(new SelectOption('Brochures / Catalogs','Brochures / Catalogs'));
      options.add(new SelectOption('Business Cards & Letterhead','Business Cards & Letterhead'));
      options.add(new SelectOption('CAD','CAD'));
      options.add(new SelectOption('Illustrations','Illustrations'));
      options.add(new SelectOption('Other','Other'));
      options.add(new SelectOption('Sign / Poster Design','Sign / Poster Design'));
      options.add(new SelectOption('Web Graphics / Clipart / Icons','Web Graphics / Clipart / Icons'));
      return options;
   }
   
   public List<SelectOption> getSoftwareProgrammingOptions() {
      List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('.NET','.NET'));
      options.add(new SelectOption('Access','Acces'));
      options.add(new SelectOption('Apple / Mac','Apple / Mac'));
      options.add(new SelectOption('Assembly Language','Assembly Language'));
      options.add(new SelectOption('C','C'));
      options.add(new SelectOption('C#','C#'));
      options.add(new SelectOption('C++','C++'));
      options.add(new SelectOption('Database Programming & Support','Database Programming & Support'));
      options.add(new SelectOption('Game Development','Game Development'));
      options.add(new SelectOption('Java','Java'));
      options.add(new SelectOption('Linux','Linux'));
      options.add(new SelectOption('Microsoft','Microsft'));
      options.add(new SelectOption('Microsoft SQL Server','Microsoft SQL Server'));
      options.add(new SelectOption('Oracle','Oracle'));
      options.add(new SelectOption('Other','Other'));
      options.add(new SelectOption('PDA / Handheld','PDA / Handheld'));
      options.add(new SelectOption('Perl','Perl'));
      options.add(new SelectOption('SAP','SAP'));
      options.add(new SelectOption('SQL','SQL'));
      options.add(new SelectOption('Sybase','Sybase'));
      options.add(new SelectOption('System Admin','System Admin'));
      options.add(new SelectOption('UNIX','UNIX'));
      options.add(new SelectOption('Visual Basic','Visual Basic'));

      return options;
   }      
   
   public List<SelectOption> getWebDevelopmentOptions() {
      List<SelectOption> options = new List<SelectOption>();
      options.add(new SelectOption('.NET / ASP','.NET / ASP'));
      options.add(new SelectOption('Ajax','Ajax'));
      options.add(new SelectOption('CGI','CGI'));
      options.add(new SelectOption('Cold Fusion','Cold Fusion'));
      options.add(new SelectOption('Content Generation','Content Generation'));
      options.add(new SelectOption('Delphi','Delphi'));
      options.add(new SelectOption('Flash','Flash'));
      options.add(new SelectOption('Javascript','Javascript'));
      options.add(new SelectOption('JSP / J2EE','JSP / J2EE'));
      options.add(new SelectOption('Link Building','Link Building'));
      options.add(new SelectOption('MS SQL','MS SQL'));
      options.add(new SelectOption('MySQL','MySQL'));
      options.add(new SelectOption('Other','Other'));
      options.add(new SelectOption('Perl','Perl'));
      options.add(new SelectOption('PHP','PHP'));
      options.add(new SelectOption('PostgreSQL','PostgreSQL'));
      options.add(new SelectOption('Python','Python'));
      options.add(new SelectOption('Script Installation','Script Installation'));
      options.add(new SelectOption('Search Engine Optimization/SEO','Search Engine Optimization/SEO'));
      options.add(new SelectOption('Search Engine Submissions','Search Engine Submissions'));
      options.add(new SelectOption('Site Usability Testing','Site Usability Testing'));
      options.add(new SelectOption('Template Design','Template Design'));
      options.add(new SelectOption('Web Security','Web Security'));
      options.add(new SelectOption('Website Design','Website Design'));
      options.add(new SelectOption('Website Promotion / Marketing','Website Promotion / Marketing'));
      options.add(new SelectOption('XML','XML'));
      options.add(new SelectOption('XSL','XSL'));
      return options;
   }
      
   public void setAudioVideoMultimedia(String[] selectedAudioVideoMultimedia) {
   	  this.selectedAudioVideoMultimedia = selectedAudioVideoMultimedia;
   }
   
   public String[] getAudioVideoMultimedia() {
   	  return selectedAudioVideoMultimedia;
   }
   
   public void setGraphicDesign(String[] selectedGraphicDesign) {
   	  this.selectedGraphicDesign = selectedGraphicDesign;
   }
   
   public String[] getGraphicDesign() {
   	  return selectedGraphicDesign;
   }
   
   public void setSoftwareProgramming(String[] selectedSoftwareProgramming) {
   	  this.selectedSoftwareProgramming = selectedSoftwareProgramming;
   }
   
   public String[] getSoftwareProgramming() {
   	  return selectedSoftwareProgramming;
   }
   
   public void setWebDevelopment(String[] selectedWebDevelopment) {
   	  this.selectedWebDevelopment = selectedWebDevelopment;
   }
   
   public String[] getWebDevelopment() {
   	  return selectedWebDevelopment;
   }
   
   public String listToString(List<String> listToString) {
      String returnString = '';
      for (String s : listToString) {
         	returnString = returnString + s + '; ';
      }
      return returnString.trim();
   }
    
   public PageReference save() {
      User u = new User();
      u.Username = username;
      u.Email = email;

      //u.CommunityNickname = communityNickname;
      u.CommunityNickname = username;
        
      String accountId = PORTAL_ACCOUNT_ID;

      // lastName is a required field on user, but if it isn't specified, we'll default it to the username
      String userId = Site.createPortalUser(u, accountId, password);
      if (userId != null) {
      	 User cId = [SELECT User.ContactId FROM User WHERE Id = :userId LIMIT 1];
      	 Contact c = new Contact(Id=cId.ContactId);
      	 if (selectedAudioVideoMultimedia.size() > 0) {
      	 	c.Audio_Video_and_Multimedia__c = listToString(getAudioVideoMultimedia());
      	 }
      	 if (selectedGraphicDesign.size() > 0) {
      	    c.Graphic_Design__c = listToString(getGraphicDesign());
      	 }
      	 if (selectedSoftwareProgramming.size() > 0) {      	    
      	    c.Software_Programming__c = listToString(getSoftwareProgramming());
      	 }
      	 if (selectedWebDevelopment.size() > 0) {      	    
      	    c.Web_Development__c = listToString(getWebDevelopment());
      	 }
      	 update(c);
         if (password != null && password.length() > 1) {
            return Site.login(username, password, null);
         }
         else {
            PageReference page = System.Page.RegisterConfirm;
            page.setRedirect(true);
            return page;
         }
      }
      return null;
   }  
     
   public PageReference register1() {   	
   	  return Page.Register1;
   }
   
   public PageReference register2() {
      if (!isValidPassword()) {
         ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
         ApexPages.addMessage(msg);
         return null;
      }    	
   	  return Page.Register2;
   }
   
}