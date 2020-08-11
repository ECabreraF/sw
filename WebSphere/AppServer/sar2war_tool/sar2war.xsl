<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    version="1.0">
<xsl:output method="xml" encoding="UTF-8" indent="yes"/>
<xsl:strip-space elements="*"/>


  <!--======================================================================-->
  <!-- This file contains an XSLT transformation stylesheet which           -->
  <!-- constructs a result tree from a number of XML sources by filtering   -->
  <!-- reordering and adding arbitrary structure. This file is              -->
  <!-- automatically generated by the XML Mapper tool from IBM WebSphere    -->
  <!-- Studio Workbench.                                                    -->
  <!--======================================================================-->
			
  <!--======================================================================-->
  <!--                          The Root Element                            -->
  <!-- The "Root Element" section specifies which template will be          -->
  <!-- invoked first thus determining the root element of the result tree.  -->
  <!--======================================================================-->

  <xsl:template match="/">
<xsl:text disable-output-escaping="yes">&lt;!DOCTYPE web-app PUBLIC	"-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN"
"http://java.sun.com/dtd/web-app_2_3.dtd"&gt;
</xsl:text>
    
    <xsl:apply-templates select="/sip-app"/>
  </xsl:template>


  <!--======================================================================-->
  <!--                         Remaining Templates                          -->
  <!-- The remaining section defines the template rules. The last template  -->
  <!-- rule is a generic identity transformation used for moving complete   -->
  <!-- tree fragments from an input source to the result tree.              -->
  <!--======================================================================-->

  <!-- Newly-defined element template -->
  <xsl:template name="filter-class">
    <filter-class>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue18'"/>
      </xsl:attribute>
    </filter-class>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="jsp-file">
    <jsp-file>
    </jsp-file>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="error-page">
    <error-page>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue58'"/>
      </xsl:attribute>

      <xsl:call-template name="exception-type"/>
      <xsl:call-template name="location"/>
    </error-page>
  </xsl:template>

  <!-- Composed element template -->
  <xsl:template match="login-config">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="/sip-app/login-config/auth-method"/>
      <xsl:apply-templates select="/sip-app/login-config/realm-name"/>
      <xsl:call-template name="form-login-config"/>
    </xsl:copy>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="url-pattern">
    <url-pattern>/<xsl:value-of select="servlet-name"/></url-pattern>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="http-method">
    <http-method>
     <xsl:value-of select="'POST'"/>
    </http-method>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="form-login-page">
    <form-login-page>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue91'"/>
      </xsl:attribute>
    </form-login-page>
  </xsl:template>

  <!-- Newly-defined element template -->
  <!--xsl:template name="filter">
    <filter>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue11'"/>
      </xsl:attribute>
      <xsl:call-template name="icon"/>
      <xsl:call-template name="filter-name"/>
      <xsl:call-template name="display-name"/>
      <xsl:call-template name="description"/>
      <xsl:call-template name="filter-class"/>
      <xsl:call-template name="init-param"/>
    </filter>
  </xsl:template-->

  <!-- Newly-defined element template -->
  <xsl:template name="mime-mapping">
    <mime-mapping>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue53'"/>
      </xsl:attribute>
      <xsl:call-template name="extension"/>
      <xsl:call-template name="mime-type"/>
    </mime-mapping>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="form-login-config">
    <form-login-config>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue90'"/>
      </xsl:attribute>
      <xsl:call-template name="form-login-page"/>
      <xsl:call-template name="form-error-page"/>
    </form-login-config>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="exception-type">
    <exception-type>
    </exception-type>
  </xsl:template>

  <!-- Rename transformation template -->
  <xsl:template match="resource-name">
    <web-resource-name>
      <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
    </web-resource-name>
  </xsl:template>

  <!-- Composed element template -->
  <xsl:template match="sip-app">
    <web-app>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="icon"/>
      <xsl:apply-templates select="display-name"/>
      <xsl:apply-templates select="description"/>
      <xsl:apply-templates select="distributable"/>
      <!--distributable>
        <xsl:apply-templates select="@id"/>
        <xsl:value-of select="distributable/text()"/>
      </distributable-->
      <xsl:apply-templates select="context-param"/>
      <!--xsl:call-template name="filter"/>
      <xsl:call-template name="filter-mapping"/-->
      <xsl:apply-templates select="listener"/>
      <xsl:apply-templates select="servlet"/>

      <!-- <xsl:apply-templates select="servlet-mapping"/> -->
      <!-- instead of transofm servlet-mapping, we need to create servlet-mapping even if not exist in sip.xml.
           the info exist in the servlet map
      -->
      <xsl:call-template name="create-servlet-mapping"/>

      <!-- <xsl:apply-templates select="session-config"/> -->
      <!--xsl:call-template name="mime-mapping"/>
      <xsl:call-template name="welcome-file-list"/>
      <xsl:call-template name="error-page"/>
      <xsl:call-template name="taglib"/-->
      <xsl:apply-templates select="resource-env-ref"/>
      <xsl:apply-templates select="resource-ref"/>
      <xsl:apply-templates select="security-constraint"/>
      <xsl:apply-templates select="login-config"/>
      <xsl:apply-templates select="security-role"/>
      <xsl:apply-templates select="env-entry"/>
      <xsl:apply-templates select="ejb-ref"/>
      <xsl:apply-templates select="ejb-local-ref"/>
    </web-app>
  </xsl:template>

  <!-- Composed element template -->
  <xsl:template match="servlet-mapping">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="servlet-name"/>
      <xsl:call-template name="url-pattern"/>
    </xsl:copy>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="create-servlet-mapping">
	<xsl:for-each select="servlet">
		<servlet-mapping>
      			<servlet-name><xsl:value-of select="servlet-name" /></servlet-name>
	 	       <url-pattern>/<xsl:value-of select="servlet-name" /></url-pattern>      
    		</servlet-mapping>
	</xsl:for-each>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="filter-name">
    <filter-name>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue15'"/>
      </xsl:attribute>
    </filter-name>
  </xsl:template>

  <!-- Composed element template -->
  <xsl:template match="servlet">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="icon"/>
      <xsl:apply-templates select="servlet-name"/>
      <xsl:apply-templates select="display-name"/>
      <xsl:apply-templates select="description"/>

      <!-- Choice Construct -->
      <xsl:choose>
        <xsl:when test="servlet-class">
          <xsl:apply-templates select="servlet-class"/>
        </xsl:when>
      </xsl:choose>
      <!-- End of Choice Construct -->
      <xsl:apply-templates select="init-param"/>

       <!-- add "load-on-startup in 2 cases: the first, it exist, the 2nd the siplet is also listener -->
      <!-- original <xsl:apply-templates select="load-on-startup"/> -->		
      <xsl:choose>
   		<xsl:when test="load-on-startup">
			<!-- <load-on-startup/> -->
			<!-- <xsl:copy-of select="load-on-startup" /> -->
      		</xsl:when>
 		<xsl:otherwise>
			<xsl:call-template name="create-servlet-load-on-startup">
				<xsl:with-param name="servlet-class-name" select="servlet-class" />
			</xsl:call-template>
		</xsl:otherwise>
       </xsl:choose>

      <xsl:apply-templates select="run-as"/>
      <xsl:apply-templates select="security-role-ref"/>
    </xsl:copy>
  </xsl:template>
  
   <!-- Newly-defined element template -->
  <xsl:template name="create-servlet-load-on-startup">
	<xsl:param name="servlet-class-name" />
	<xsl:variable name="isListener" select="/sip-app/listener[listener-class=$servlet-class-name]" />
	<xsl:if test="$isListener">
		<load-on-startup/>
	</xsl:if>	
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="mime-type">
    <mime-type>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue55'"/>
      </xsl:attribute>
    </mime-type>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="taglib">
    <taglib>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue61'"/>
      </xsl:attribute>
      <xsl:call-template name="taglib-uri"/>
      <xsl:call-template name="taglib-location"/>
    </taglib>
  </xsl:template>

  <!-- Composed element template -->
  <xsl:template match="resource-collection">
    <web-resource-collection>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="resource-name"/>
      <xsl:apply-templates select="description"/>
	  <xsl:call-template name="url-pattern"/>
      <xsl:call-template name="http-method"/>
    </web-resource-collection>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="form-error-page">
    <form-error-page>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue92'"/>
      </xsl:attribute>
    </form-error-page>
  </xsl:template>

  <!-- Composed element template -->
  <xsl:template match="security-constraint">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates select="display-name"/>
      <xsl:apply-templates select="resource-collection"/>
      <xsl:apply-templates select="auth-constraint"/>
      <xsl:apply-templates select="user-data-constraint"/>
    </xsl:copy>
  </xsl:template>

  <!-- Newly-defined element template -->
  <!--xsl:template name="filter-mapping">
    <filter-mapping>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue23'"/>
      </xsl:attribute>
      <xsl:call-template name="filter-name"/>

      <xsl:call-template name="servlet-name"/>
    </filter-mapping>
  </xsl:template-->

  <!-- Newly-defined element template -->
  <xsl:template name="taglib-location">
    <taglib-location>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue63'"/>
      </xsl:attribute>
    </taglib-location>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="extension">
    <extension>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue54'"/>
      </xsl:attribute>
    </extension>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="welcome-file">
    <welcome-file>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue57'"/>
      </xsl:attribute>
    </welcome-file>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="error-code">
    <error-code>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue59'"/>
      </xsl:attribute>
    </error-code>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="location">
    <location>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue60'"/>
      </xsl:attribute>
    </location>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="taglib-uri">
    <taglib-uri>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue62'"/>
      </xsl:attribute>
    </taglib-uri>
  </xsl:template>

  <!-- Newly-defined element template -->
  <xsl:template name="welcome-file-list">
    <welcome-file-list>
      <xsl:attribute name="id">
        <xsl:value-of select="'idvalue56'"/>
      </xsl:attribute>
      <xsl:call-template name="welcome-file"/>
    </welcome-file-list>
  </xsl:template>

  <!-- Identity transformation template -->
  <xsl:template match="*|@*|comment()|processing-instruction()|text()">
    <xsl:copy>
      <xsl:apply-templates select="*|@*|comment()|processing-instruction()|text()"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>