<%-- IBM Confidential OCO Source Material --%>
<%-- 5724-i63, 5724-H88 (C) COPYRIGHT International Business Machines Corp. 2010 --%>
<%-- The source code for this program is not published or otherwise divested --%>
<%-- of its trade secrets, irrespective of what has been deposited with the --%>
<%-- U.S. Copyright Office. --%>

<%@ page import="java.util.Iterator,com.ibm.ws.console.core.item.ActionSetItem,com.ibm.ws.security.core.SecurityContext"%>
<%@ page import="java.util.StringTokenizer, java.util.Vector"%>
<%@ page import="java.util.HashSet"%>
<%@ page import="java.util.Set"%>
<%@ page import="com.ibm.ws.*"%>
<%@ page import="com.ibm.wsspi.*"%>
<%@ page import="com.ibm.websphere.management.authorizer.AdminAuthorizer"%>
<%@ page import="com.ibm.websphere.management.authorizer.AdminAuthorizerFactory"%>
<%@ page import="com.ibm.websphere.management.metadata.ManagedObjectMetadataAccessor"%>
<%@ page import="com.ibm.websphere.management.metadata.ManagedObjectMetadataAccessorFactory"%>
<%@ page import="com.ibm.ws.console.core.selector.*"%>
<%@ page import="com.ibm.ws.console.core.ConfigFileHelper"%>  <%-- LIDB2303A --%>
<%@ page import="com.ibm.ws.console.core.SecurityHelper"%>
<%@ page import="com.ibm.ws.xd.admin.utils.ConfigUtils"%>

<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tiles.tld" prefix="tiles" %>

<tiles:useAttribute name="buttonCount" classname="java.lang.String" />
<tiles:useAttribute name="definitionName" classname="java.lang.String" />
<tiles:useAttribute name="includeForm" classname="java.lang.String" />
<tiles:useAttribute name="formName" classname="java.lang.String" />
<tiles:useAttribute name="rolemap" classname="java.util.Map" ignore="true"/>

<%
int count = 0;

try {
        count = Integer.parseInt(buttonCount);
    }
    catch( java.lang.NumberFormatException ex){
        count = 8;
        }
%>

<%-- Layout component 
  Render a list of tiles in a vertical column
  @param : list List of names to insert 
  
--%>  
<tiles:useAttribute id="list" name="actionList" classname="java.util.List" />

<!-- gets all the action list items which matches with the contextType and 
     compatibilty criteria using plugin registry API -->

<%
int wasVersion = ConfigUtils.getWASVersionInts()[0];

String contextType=(String)request.getAttribute("contextType");
String contextId = (String)request.getAttribute("contextId");
String perspective = (String)request.getAttribute("perspective");
String formAction = (String)request.getAttribute("formAction");

AdminAuthorizer adminAuthorizer = AdminAuthorizerFactory.getAdminAuthorizer();
String contextUri = ConfigFileHelper.decodeContextUri(contextId);

//Build scope list
Set rolesInCurrentContext = null;

if (rolemap != null) {
   rolesInCurrentContext = new HashSet();

   for (Iterator j = rolemap.values().iterator(); j.hasNext(); ) {
      rolesInCurrentContext.addAll((Set) j.next());
   }
}

java.util.Properties props= null;

java.util.ArrayList actionList_ext =  new java.util.ArrayList();
for(int i=0;i<list.size(); i++)
     actionList_ext.add(list.get(i));

IPluginRegistry registry= IPluginRegistryFactory.getPluginRegistry();

String extensionId = "com.ibm.websphere.wsc.actionSet";
IConfigurationElementSelector ic = new ConfigurationElementSelector(contextType,extensionId);

IExtension[] extensions= registry.getExtensions(extensionId,ic);

if(extensions!=null && extensions.length>0){
    if(contextId!=null && contextId!="nocontext"){
        props = ConfigFileHelper.getNodeMetadataProperties((String)contextId); //213515
    }
    if(formName!=null)
    props = ConfigFileHelper.getAdditionalAdaptiveProperties(request, props, formName); // LIDB2303A
    else
       props = ConfigFileHelper.getAdditionalAdaptiveProperties(request, props);
    
    actionList_ext = ActionSetSelector.getButtons(extensions,actionList_ext,props,perspective, definitionName);
} 
pageContext.setAttribute("actionList_ext",actionList_ext);

boolean buttonsShown = false;

%>

<%
Iterator i=actionList_ext.iterator();
int listsize = actionList_ext.size();
int excessItems = 0;
String buttonName = "";
if (listsize > (count+1) ) {
   excessItems = 0;     
} else {
   count = listsize;
}

%>
        
<% if (listsize > 0) { %>

        <table border="0" cellpadding="3" cellspacing="0" valign="top" width="100%" summary="Framing Table" CLASS="button-section">
        <tr valign="top">
        <td class="table-button-section"  nowrap> 
        
        
    <%  
    if (includeForm.equals("yes")){  
    %>          

        <form method="POST" action="toolbar.do" class="nopad">

    <% 
    } 

    for (int ctr=0; ctr < listsize ; ++ctr) {
        ActionSetItem item = (ActionSetItem)i.next();
        String action = item.getAction();
        buttonName = action; 
        boolean showItem = true;
        if (SecurityContext.isSecurityEnabled()) {
            String[] roles = item.getRoles();
            showItem = false;
            for (int idx = 0; idx < roles.length; idx++) {
               
                     //By default if scope isn't defined, we rely on the scopes associated with ever item in the collection list, as defined in rolesInCurrentScope
                     //to determine whether to display a button.
                     //If a scope is set, then we check whether the caller has any access to that scope
                     if (item.getScope() == null || item.getScope().equals("")) {
           
                           //If rolesInCurrentScope is null, then that means we weren't given a rolemap by the collectionTableLayout,
                           //So we should probably display the buttons by default.
                           if (rolesInCurrentContext == null || rolesInCurrentContext.contains(roles[idx])) {
                                  showItem = true;
		                    }
                           
                     } else {
                           if (SecurityHelper.checkAccessToScope(item.getScope(), roles[idx])) {
                                  showItem = true;
                           }
                     }
            }   // for roles loop
        }
%> 

 <%
        if (showItem == true) {
        	buttonsShown = true;
			if (buttonName.equals("middlewareapps.button.add")) {
               Set cellRoles = ConfigFileHelper.getRoles(contextId);

               // Only cell admin/deployer/configurator can add new apps.
               if ((cellRoles.contains(AdminAuthorizer.ADMIN_ROLE)) ||
                   (cellRoles.contains(AdminAuthorizer.CONFIG_ROLE)) ||
                   (cellRoles.contains(AdminAuthorizer.DEPLOYER_ROLE))) {
                   %>
				<input type="submit" name="<%=action%>" value="<bean:message key="<%=buttonName %>"/>" class="buttons_functions"/>
                   <%
               }
			} else {        %>
                <input type="submit" name="<%=action%>" value="<bean:message key="<%=buttonName %>"/>" class="buttons_functions"/>

<%			}
        } //end if
    %>

    
    <%
      } // end loop
    %>  
    
    <% if (excessItems > 0) { %>
    
    &nbsp;&nbsp;
    
    <SELECT name="excessAction">
    
    <% for (int ctr=0; ctr < excessItems ; ++ctr) {
        ActionSetItem item2 = (ActionSetItem)i.next();
        String action2 = item2.getAction();
        buttonName = action2; 
        boolean showExcessItem = true;
        if (SecurityContext.isSecurityEnabled()) {
            String[] roles = item2.getRoles();
            showExcessItem = false;
            for (int idx = 0; idx < roles.length; idx++) {
                if (adminAuthorizer.checkAccess(contextUri, roles[idx])) {
                    showExcessItem = true;
                    break;
                }
            }
        }
        if (showExcessItem == true) {
    %>
    <option value="<%=action2 %>">
    <bean:message key="<%=buttonName%>"/>
    </option> 
    <%
        } //end if
    %>
    <%
      } // end loop
    %>  
    
    </SELECT>
    <input type="submit" name="go" value="<bean:message key="button.go"/>" class="buttons_functions"/>
    <% } %>

    <input type="hidden" name="definitionName" value="<%=definitionName%>"/>
    <input type="hidden" name="buttoncontextType" value="<%=contextType%>"/>
    <input type="hidden" name="buttoncontextId" value="<%=contextId%>"/>
    <input type="hidden" name="buttonperspective" value="<%=perspective%>"/> 
    <input type="hidden" name="formAction" value="<%=formAction%>"/>  
    

    <% if (includeForm.equals("yes")) {%> 
      </form>
    <% } %>
    
        </td>
        </tr>
        </table>


<% } %>

<%
if(!buttonsShown){
	request.setAttribute("hide.check.boxes","true");
}
%>
 
