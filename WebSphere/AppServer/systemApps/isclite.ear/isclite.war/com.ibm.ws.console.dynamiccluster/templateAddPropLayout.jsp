<%-- IBM Confidential OCO Source Material --%>
<%-- 5724-i63, 5724-H88 (C) COPYRIGHT International Business Machines Corp. 1997, 2010 --%>
<%-- The source code for this program is not published or otherwise divested --%>
<%-- of its trade secrets, irrespective of what has been deposited with the --%>
<%-- U.S. Copyright Office. --%>

<%@ page import="java.util.*"%>
<%@ page import="org.apache.struts.tiles.beans.SimpleMenuItem"%>
<%@ page import="com.ibm.ws.*"%>
<%@ page import="com.ibm.wsspi.*"%>
<%@ page import="com.ibm.ws.console.core.selector.*"%>
<%@ page import="com.ibm.ws.console.core.item.*"%>
<%@ page import="com.ibm.ws.console.core.ConfigFileHelper"%>
<%@ page import="com.ibm.websphere.management.authorizer.AdminAuthorizer"%>
<%@ page import="com.ibm.websphere.management.authorizer.AdminAuthorizerFactory"%>
<%@ page import="com.ibm.websphere.management.metadata.*"%>
<%@ page import="com.ibm.ws.security.core.SecurityContext"%>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/tiles.tld" prefix="tiles" %>

<!-- this jsp passes serverRefId from link -->

<tiles:useAttribute id="list" name="list" classname="java.util.List"/>
<tiles:useAttribute name="formName" classname="java.lang.String"/>

<bean:define id="resourceUri" name="<%=formName%>" property="resourceUri"/>
<bean:define id="refId"    name="<%=formName%>" property="refId"/>
<bean:define id="serverRefId"    name="<%=formName%>" property="serverRefId"/>
<bean:define id="action"    name="<%=formName%>" property="action"/>
<bean:define id="contextId"    name="<%=formName%>" property="contextId"/>
<bean:define id="perspective"    name="<%=formName%>" property="perspective"/>


<!-- gets all the link items which matches with the contextType and
     compatibilty criteria using plugin registry API -->

<%
AdminAuthorizer adminAuthorizer = AdminAuthorizerFactory.getAdminAuthorizer();
String contextUri = ConfigFileHelper.decodeContextUri((String)contextId);

String contextType=(String)request.getAttribute("contextType");
java.util.Properties props= null;

java.util.ArrayList list_ext =  new java.util.ArrayList();
for(int i=0;i<list.size(); i++)
     list_ext.add(list.get(i));

IPluginRegistry registry= IPluginRegistryFactory.getPluginRegistry();

String extensionId = "com.ibm.websphere.wsc.link";
IConfigurationElementSelector ic = new ConfigurationElementSelector(contextType,extensionId);

IExtension[] extensions= registry.getExtensions(extensionId,ic);

if(extensions!=null && extensions.length>0){
    if(contextId!=null && contextId!="nocontext"){
      props = ConfigFileHelper.getNodeMetadataProperties((String)contextId); //213515
    }

    props = ConfigFileHelper.getAdditionalAdaptiveProperties(request, props, formName); // LIDB2303A

    // LI3969
	// Add user roles to props
    String[] userRoles = (String[]) session.getAttribute("userRoles");
    if (userRoles != null) {
        props.put("userRoles", userRoles);
    }

    // list_ext = LinkSelector.getLinks(extensions,list_ext,props,(String)perspective,"additional.properties");

    // TODO: use this one if we don't support WAS v6.0.2.. The API below is new in WAS 6.1 to do the cross component dynamic link support
    list_ext = LinkSelector.getLinks(extensions,list_ext,props,(String)perspective,"additional.properties", request, formName); // LIDB3509C
}
pageContext.setAttribute("list_ext",list_ext);


%>

<%

            String parentType="";
            String resourceUri1="";
            for(int z=0;z<list_ext.size();z++)
            {
               String link1="";
                NavigatorItem nitem = (NavigatorItem) list_ext.get(z);
                if(nitem.getLink()!=null && nitem.getLink()!=""){
                if(nitem.getLink().indexOf("parentType=")!=-1){
                StringTokenizer pt1 = new StringTokenizer(nitem.getLink(),"&");
                while(pt1.hasMoreTokens()){
                    StringTokenizer pt2 = new StringTokenizer(pt1.nextToken(),"=");
                    while(pt2.hasMoreTokens())
                    {
                        String pt2token = pt2.nextToken();
                        if(pt2token.equalsIgnoreCase("parentType"))
                        {
                        parentType=pt2.nextToken();
                        }
                        if(pt2token.equalsIgnoreCase("resourceUri"))
                        {
                            resourceUri1=pt2.nextToken();
                        }

                    }
                }
                String refId1 = LinkSelector.getReferenceId(parentType, resourceUri1, request,(String)contextId);
                link1 = nitem.getLink() + "&parentRefId=" + refId1 + "&serverRefId=" + serverRefId + "&contextId=" + contextId + "&perspective=" + perspective ;
            }

                else
                if (nitem.getLink().indexOf("resourceUri=") != -1 ) {
                link1 = nitem.getLink() + "&parentRefId=" + refId + "&serverRefId=" + serverRefId + "&contextId=" + contextId + "&perspective=" + perspective ;
                } else {
                link1 = nitem.getLink() + "&resourceUri=" + resourceUri + "&parentRefId=" + refId + "&serverRefId=" + serverRefId + "&contextId=" + contextId + "&perspective=" + perspective ;
                }

                nitem.setLink(link1);

                }


            }
                        %>

                        <%
    List staticTree = new ArrayList();
    staticTree.add("admin_domain");
    List staticTreeLevels = new ArrayList();
    int level = 0;
    staticTreeLevels.add(new Integer(level));
    int parIndex = 0;
    int counter = 0;
    String strlevel = "";
    String priorPar = "";
    int priorlevel = 1;
    String externalMarker = "";

%>


<% if (list_ext.size() > 0 ) { %>


         <logic:iterate id="item" name="list_ext" type="com.ibm.ws.console.core.item.NavigatorItem" >
<%



    String targetString = "detail";
    String taskClass = "sub-category";
    String groupClass = "sub-category-container";
    boolean showItem = true;
    if (SecurityContext.isSecurityEnabled()) {
        String[] roles = item.getRoles();
        showItem = false;
        for (int i = 0; i < roles.length; i++) {
            if (adminAuthorizer.checkAccess(contextUri, roles[i])) {
                showItem = true;
                break;
            }
        }
    }
    if (showItem == true) {
%>
<%
        String parentId = item.getParentId();
        if (parentId.equals("root")) {
            parentId = "admin_domain";
        }
        String link = item.getLink();
        String icon = request.getContextPath()+"/images/onepix.gif";

        %>

<%
        if (item.isExternalLink()) {
           externalMarker = "...";
           targetString = "_blank";
%>


<%
        }

        if (link.equals("")) {



                if (staticTree.indexOf(parentId)>-1) {
                        parIndex = staticTree.indexOf(parentId);
                        level = ((Integer)staticTreeLevels.get(parIndex)).intValue();
                        level = level + 1;
                        staticTree.add(item.getNodeId());
                        staticTreeLevels.add(new Integer(level));


                         if (level > 1)
                         { // sub item
                           taskClass="sub-category";
                           groupClass="sub-category-container";
                         }
                         else // main item
                         {
                           taskClass="main-category";
                           groupClass="main-category-container";
                         }

                        if (level == 1) {

                              if (counter > 0) {
                                 for (int i=1;i<priorlevel;i++) {
                                    out.println("</DIV>");
                                 }
                              }
%>

                            <DIV id="<%=item.getNodeId()%>" class="<%=taskClass%>" style='margin-left:<%=(level*.30)%>em;'>
                            <%--<a href="javascript:showHideNavigation('<%=item.getNodeId()%>')" style="color:#336699;text-decoration:none">
                            <IMG id="img_<%=item.getNodeId()%>" SRC="<%=request.getContextPath()+"/"%>images/arrow_collapsed.gif" BORDER="0" ALIGN="absmiddle"/>

                            </A>--%>
                            <bean:message key='<%=item.getTooltip()%>'/>
                            </DIV>

                            <DIV id="child_<%=item.getNodeId()%>" class="<%=groupClass%>" style='margin-left:<%=(level*.30)%>em'>
							
<%
                        }
                        else {
                           if (counter > 0) {
                              for (int i=1;i<priorlevel-1;i++) {
								 out.println("</DIV>");
                              }
                           }
                           if (priorlevel >= level) {
							  %>
                                </UL>
                              <%
						   }
%>						

                            <DIV id="<%=item.getNodeId()%>" class="<%=taskClass%>">
                            <a href="javascript:showHideNavigation('<%=item.getNodeId()%>')" style="color:#336699;text-decoration:none">
                            <IMG id="img_<%=item.getNodeId()%>" SRC="<%=request.getContextPath()+"/"%>images/arrow_expanded.gif" BORDER="0" ALIGN="absmiddle" ALT="<bean:message key="wsc.expand.collapse.alt"/>"/>
                            <bean:message key='<%=item.getTooltip()%>'/>
                            </A>
                            </DIV>

                            <DIV id="child_<%=item.getNodeId()%>" class="<%=groupClass%>" style="display:block">
                            <SCRIPT>
                                showHideNavigation('<%=item.getNodeId()%>');
                            </SCRIPT>

<%
                        }
                }


        } else {
                if (staticTree.indexOf(parentId)>-1) {

                        parIndex = staticTree.indexOf(parentId);
                        level = ((Integer)staticTreeLevels.get(parIndex)).intValue();
                        level = level + 1;
                        if (level < priorlevel) {
						   %>
                           </DIV>
							  <UL CLASS="main-child">
                           <%
						}
                        if (level > priorlevel) {
						   %>
							  <UL CLASS="main-child">
						   <%
						}

%>

                        <%if (item.getSummary()!=null) {
                            request.setAttribute("com.ibm.ws.console.formName" , formName);
                         %>

                        <!--added for summary view -->

                          <LI style="list-style-type: none;margin-left:-1.5em" TITLE="<bean:message key='<%=item.getDescription()%>'/>">
                            <DIV id="item<%=counter %>" class="<%=taskClass%>">
                            <a href="javascript:showHideNavigation('item<%=counter%>')" style="color:#336699;text-decoration:none">
                            <IMG id="img_item<%=counter%>" SRC="<%=request.getContextPath()+"/"%>images/arrow_expanded.gif" BORDER="0" ALIGN="absmiddle" ALT="<bean:message key="wsc.expand.collapse.alt"/>"/>
                            </A>
                            <A HREF="<%=link%>" style="font-size:200%"><bean:message key='<%=item.getTooltip()%>'/></A>
                            </DIV>


                            <DIV id="child_item<%=counter%>" class="<%=groupClass%>" style="margin-left:1.5em;display:block">
                            <TABLE WIDTH="70%" cellspacing="0" cellpadding="2">
                            <TBODY ID="">
                                <TR>
                                <TD VALIGN="top">
                            <tiles:insert definition="<%=item.getSummary()%>" flush="false"/>
                                </TD>
                                <TD VALIGN="top" STYLE="padding-top:5px">
                                <A HREF="<%=link%>" class="linkButton">
                                    <bean:message key='button.details'/>
                                </A>
                                </TD>
                                </TR>
                            </TBODY>
                            </TABLE>
                            </div>
                            <SCRIPT>
                                showHideNavigation('item<%=counter%>');
                            </SCRIPT>
                        </LI>

                        <% } else {%>


                        <LI CLASS="nav-bullet" TITLE="<bean:message key='<%=item.getDescription()%>'/>">

                        <a href="<%=link%>">
                        <bean:message key='<%=item.getTooltip()%>'/>
						</a>
                        </LI>
                     <%  }
                       %>


<%

                }

        }

        priorPar = parentId;
        priorlevel = level;

%>


<%
        if (item.isExternalLink()) {
            externalMarker = "";
            targetString = "detail";
%>

<%
        }
        counter = counter + 1;
    }
%>

</logic:iterate>

</UL></DIV>




 <% } %>

