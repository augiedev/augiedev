public with sharing class UserRoleController {

   String orgHierarchy = '';
   String breakLines = '<br />';
   List<UserRole> urList = [SELECT Id, ParentRoleId, Name From UserRole where ParentRoleId = ''];
   Map<Id, String> userRoles = new Map<Id, String>();
   //public String selectedUserRole{ get; set; }

   public String getOrgHierarchy() {
   	  getRoles('');
   	  return orgHierarchy;
   }
   
   public void getRoles(String roleId) {
   	 
      List<UserRole> ur = [SELECT Id, ParentRoleId, Name From UserRole where ParentRoleId = :roleId and PortalRole = null and Name != null];
      if (!ur.isEmpty()) {
         for (UserRole u : ur) {
      	 breakLines += '&nbsp;&nbsp;&nbsp;';         	
         	getRoles(u.Id);
         	orgHierarchy = breakLines + '* ' + u.Name + orgHierarchy;
            if (roleId != '') {
               breakLines = breakLines.substring(0, breakLines.length()-18);
            }
         }
      }
   }
   
   public String getRoleHierarchy() {
   	  GoogleViz gv = new GoogleViz();
   	  gv.cols = new list<GoogleViz.col> {
   	     new GoogleViz.Col('col1', 'Name', 'string'),
   	     new GoogleViz.Col('col1', 'Parent', 'string'),
   	     new GoogleViz.Col('col1', 'ToolTip', 'string')
   	  };
   	  List<UserRole> uRoles = [SELECT Id, Name, ParentRoleId From UserRole where PortalRole = null and Name != null];
   	  for (UserRole ur : uRoles) {
   	     userRoles.put(ur.Id, ur.Name);
   	  }
   	  for (UserRole ur : uRoles) {
   	     GoogleViz.row selectedRoleRow = new GoogleViz.row();
   	     selectedRoleRow.cells.add(new GoogleViz.cell(ur.Name));
   	     selectedRoleRow.cells.add(new GoogleViz.cell(userRoles.get(ur.ParentRoleId)));
   	     selectedRoleRow.cells.add(new GoogleViz.cell(''));
   	     gv.addRow(selectedRoleRow);
   	  }
   	  return gv.toJsonString();
   }
}