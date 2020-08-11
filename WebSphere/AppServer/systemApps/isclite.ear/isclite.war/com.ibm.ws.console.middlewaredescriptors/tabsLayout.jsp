<%-- IBM Confidential OCO Source Material --%>
<%-- 5724-J34, 5655-P28 (C) COPYRIGHT International Business Machines Corp. 2006, 2010 --%>
<%-- The source code for this program is not published or otherwise divested --%>
<%-- of its trade secrets, irrespective of what has been deposited with the --%>
<%-- U.S. Copyright Office. --%>

<%@ page import="com.ibm.ws.security.core.SecurityContext,java.util.*"%>
<%@ page import="com.ibm.ws.*"%>
<%@ page import="com.ibm.wsspi.*"%>
<%@ page import="org.apache.struts.tiles.beans.SimpleMenuItem"%>
<%@ page import="com.ibm.ws.console.core.selector.*"%>
<%@ page import="com.ibm.websphere.management.authorizer.AdminAuthorizer"%>
<%@ page import="com.ibm.websphere.management.authorizer.AdminAuthorizerFactory"%>
<%@ page import="com.ibm.websphere.management.metadata.*"%>
<%@ page import="com.ibm.ws.console.core.ConfigFileHelper"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/tiles.tld" prefix="tiles" %>

<tiles:useAttribute name="selectUri" classname="java.lang.String" />
<tiles:useAttribute name="tabList" classname="java.util.List" />
<tiles:useAttribute name="formName" classname="java.lang.String" />

<bean:define id="contextId" name="<%=formName%>" property="contextId" type="java.lang.String" toScope="request"/>
<bean:define id="perspective" name="<%=formName%>" property="perspective" type="java.lang.String" toScope="request"/> 

<!-- gets all the link items which matches with the contextType and 
     compatibilty criteria using plugin registry API -->

<%
AdminAuthorizer adminAuthorizer = AdminAuthorizerFactory.getAdminAuthorizer();
String contextUri = ConfigFileHelper.decodeContextUri((String)contextId);

String contextType=(String)request.getAttribute("contextType");
String cellname = null;
String nodename = null;
String token = null;
java.util.Properties props= null;


java.util.ArrayList tabList_ext =  new java.util.ArrayList();
for(int i=0;i<tabList.size(); i++)
     tabList_ext.add(tabList.get(i));

IPluginRegistry registry= IPluginRegistryFactory.getPluginRegistry();

String extensionId = "com.ibm.websphere.wsc.detailTab";
IConfigurationElementSelector ic = new ConfigurationElementSelector(contextType,extensionId);

IExtension[] extensions= registry.getExtensions(extensionId,ic);

if(extensions!=null && extensions.length>0){
    if(contextId!=null && contextId!="nocontext"){
      props = ConfigFileHelper.getNodeMetadataProperties((String)contextId); //213515
    }

    tabList_ext = TabSelector.getTabs(extensions,tabList_ext,props);
}   

    pageContext.setAttribute("tabList_ext",tabList_ext);

 %>






<bean:define id="perspectiveValue" name="<%= formName %>" property="perspective"/>
 <bean:define id="mbeanId" name="<%= formName %>" property="mbeanId"/>

<% String selectedBody = null;%>

<table border="0" cellpadding="0" cellspacing="0"  width="100%" role="presentation">
<tr valign="top"> 
<%  List list = (List) tabList_ext;
    Iterator iter = list.iterator();
    while (iter.hasNext()) { 
    org.apache.struts.tiles.beans.SimpleMenuItem tab = (org.apache.struts.tiles.beans.SimpleMenuItem) iter.next();
    
    boolean showItem = true;
    if (SecurityContext.isSecurityEnabled()) {
        showItem = false;
        
        String[] roles = {"administrator", "operator", "configurator", "monitor"};
        if (tab.getTooltip() != null && tab.getTooltip().equals("") == false) {
            StringTokenizer st = new StringTokenizer(tab.getTooltip(), ",");
            ArrayList al = new ArrayList();
            while(st.hasMoreTokens()) {
                al.add(st.nextToken());
            }
            roles = new String[al.size()];
            roles = (String[])al.toArray(roles);
        }

        for (int idx = 0; idx < roles.length; idx++) {
            if (adminAuthorizer.checkAccess(contextUri, roles[idx])) {
                showItem = true;
                break;
            }
        }
    }
    //skip displaying tab if showItem is false
    if (showItem == false) {
        continue;
    }
    
    String value = (String) perspectiveValue;
    String tabValue = tab.getValue();
    String href = selectUri + "?EditAction=true&perspective=" + tabValue ;
    String managedbeanId = "";
    //skip displaying runtime tab if managedbeanId is blank
    if ( (managedbeanId.equalsIgnoreCase("")) && (tabValue.equalsIgnoreCase("tab.runtime")) ) {
          continue;
    }
%>


    <% if (tabList_ext.size() == 1)  {
	  selectedBody = tab.getLink();
    %>	
    <td class="tabs-on" width="1%" nowrap height="15">
        <bean:message key='<%=tab.getValue()%>'/>
    </td>
     <% } else if ((tabList_ext.size() > 1)  && (value.equalsIgnoreCase(tabValue))) {  
		selectedBody = tab.getLink();
	%>
	<td class="tabs-on" width="1%" nowrap height="15">
        <bean:message key='<%=tab.getValue()%>'/>
        </td> 

        <td class="blank-tab" width="1%" nowrap height="15">
        <img src="<%=request.getContextPath()+"/"%>images/onepix.gif" width="2" height="10" align="absmiddle" alt=""> 
        </td>
        
  
    <% } else if ((tabList_ext.size() > 1)  && (!value.equalsIgnoreCase(tabValue))) {   %>
	 <td class="tabs-off" width="1%" nowrap height="19">
        <a class="tabs-item" href="<%=href%>"><bean:message key='<%=tab.getValue()%>'/></a>
        </td>  

        <td class="blank-tab" width="1%" nowrap height="15">
        <img src="<%=request.getContextPath()+"/"%>images/onepix.gif" width="2" height="10" align="absmiddle" alt=""> 
        </td>
        
   
   <% } %>

<% } %>
    <td class="blank-tab" width="99%" nowrap height="15">
        <img src="<%=request.getContextPath()+"/"%>images/onepix.gif" width="1" height="10" align="absmiddle" alt="">
    </td>

</tr>
</table>

<table border="0" cellpadding="10" cellspacing="0" valign="top" width="100%" summary="Framing Table">
<tr> 
<td class="layout-manager">
<tiles:insert name="<%=selectedBody%>" flush="true" />    
</td> 
</tr>
</table>