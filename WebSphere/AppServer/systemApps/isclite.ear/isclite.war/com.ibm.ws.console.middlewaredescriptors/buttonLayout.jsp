<%-- IBM Confidential OCO Source Material --%>
<%-- 5724-i63, 5724-H88 (C) COPYRIGHT International Business Machines Corp. 1997, 2010 --%>
<%-- The source code for this program is not published or otherwise divested --%>
<%-- of its trade secrets, irrespective of what has been deposited with the --%>
<%-- U.S. Copyright Office. --%>

<%@ page import="java.util.Iterator,com.ibm.ws.console.core.item.ActionSetItem,com.ibm.ws.security.core.SecurityContext"%>
<%@ page import="java.util.StringTokenizer, java.util.Vector"%>
<%@ page import="com.ibm.ws.*"%>
<%@ page import="com.ibm.wsspi.*"%>
<%@ page import="com.ibm.ws.console.core.selector.*"%>
<%@ page import="com.ibm.ws.console.core.ConfigFileHelper"%>  <%-- LIDB2303A --%>
<%@ page import="com.ibm.websphere.management.authorizer.AdminAuthorizer"%>
<%@ page import="com.ibm.websphere.management.authorizer.AdminAuthorizerFactory"%>
<%@ page import="com.ibm.websphere.management.metadata.ManagedObjectMetadataAccessor"%>
<%@ page import="com.ibm.websphere.management.metadata.ManagedObjectMetadataAccessorFactory"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tiles.tld" prefix="tiles" %>


<tiles:useAttribute name="buttonCount" classname="java.lang.String" />
<tiles:useAttribute name="definitionName" classname="java.lang.String" />
<tiles:useAttribute name="includeForm" classname="java.lang.String" />
<tiles:useAttribute name="formName" classname="java.lang.String" />
<tiles:useAttribute name="attributeList" classname="java.util.List" />


<%
int count = 0;

try {
        count = Integer.parseInt(buttonCount);
    }
    catch( java.lang.NumberFormatException ex){
        count = 6;
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

String contextType=(String)request.getAttribute("contextType");
String contextId = (String)request.getAttribute("contextId");

AdminAuthorizer adminAuthorizer = AdminAuthorizerFactory.getAdminAuthorizer();
String contextUri = ConfigFileHelper.decodeContextUri((String)contextId);

String perspective = (String)request.getAttribute("perspective");
String formAction = (String)request.getAttribute("formAction");

String cellname = null;
String nodename = null;
String token = null;
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
        
        
    <%  if (includeForm.equals("yes")){  %>          
    <form method="POST" action="toolbar.do" class="nopad">
       		<input type="hidden" name="csrfid" value="<%=request.getSession().getId()%>"/>
    <% } %>

    
     
    <%
    for (int ctr=0; ctr < listsize ; ++ctr) {
        ActionSetItem item = (ActionSetItem)i.next();
        String action = item.getAction();
        buttonName = action; 
        boolean showItem = true;
        if (SecurityContext.isSecurityEnabled()) {
            String[] roles = item.getRoles();
            showItem = false;
            for (int idx = 0; idx < roles.length; idx++) {
                if (adminAuthorizer.checkAccess(contextUri, roles[idx])) {
                    showItem = true;
                    break;
                }
            }
        }
%> 
     <logic:iterate id="selectItem" name="attributeList" type="com.ibm.ws.console.core.item.PropertyItem">
 <%
        if (showItem == true) 
        {
        	buttonsShown = true;
    %>
    

<%				
					if (buttonName.equals("middlewareserver.button.modeAction"))
  					 {
		                	String isRequired = selectItem.getRequired(); 
        		        	String strType = selectItem.getType();
                			String isReadOnly = selectItem.getReadOnly();

		                    try 
		                    {
		                        session.removeAttribute("valueVector");
		                        session.removeAttribute("descVector");
		                    }
		                    catch (Exception e) {  }
		                    
			                Vector descVector = new Vector();
		                    Vector valueVector = new Vector();
		                    StringTokenizer st1 = new StringTokenizer(selectItem.getEnumDesc(), ",");
		                    while(st1.hasMoreTokens()) 
		                    {
		                        String enumDesc = st1.nextToken();
		                        descVector.addElement(enumDesc);
		                    }
		                    StringTokenizer st = new StringTokenizer(selectItem.getEnumValues(), ",");
		                    while(st.hasMoreTokens()) 
		                    {
		                        String str = st.nextToken();
		                        valueVector.addElement(str);
		                    }
		                    session.setAttribute("descVector", descVector);
		                    session.setAttribute("valueVector", valueVector);
		                
%>
			                    <tiles:insert page="/com.ibm.ws.console.middlewaredescriptors/selectLayout.jsp" flush="false">
			                        <tiles:put name="property" value="<%=selectItem.getAttribute()%>" />
			                        <tiles:put name="isReadOnly" value="<%=isReadOnly%>" />
			                        <tiles:put name="isRequired" value="<%=isRequired%>" />
			                        <tiles:put name="label" value="<%=selectItem.getLabel()%>" />
			                        <tiles:put name="size" value="4" />
			                        <tiles:put name="units" value="<%=selectItem.getUnits()%>"/>
			                        <tiles:put name="desc" value="<%=selectItem.getDescription()%>"/>
			                        <tiles:put name="bean" value="<%=formName%>" />
			                        <tiles:put name="valueVector" value="<%=valueVector%>" />
		                        	<tiles:put name="descVector" value="<%=descVector%>" />
			                    </tiles:insert>             		
							
							    <input type="submit" name="<%=action%>" value="<bean:message key="<%=buttonName %>"/>" class="buttons_functions"/>
<%					 }
					 else
					 {
%>
							    <input type="submit" name="<%=action%>" value="<bean:message key="<%=buttonName %>"/>" class="buttons_functions"/>
<%					 }
					 	  
        } //end if
    %>
    </logic:iterate>
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
 
