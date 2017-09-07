<#--
    navigation.ftl: header navigation.
    
    Created:    2017-09-07 11:27 by Christian Berndt
    Modified:   2017-09-07 11:27 by Christian Berndt
    Version:    1.0.0
-->

<#assign home_url = htmlUtil.escape(theme_display.getURLHome()) />
<#assign is_impersonated = themeDisplay.isImpersonated() />

<#if !home_url?has_content>
    <#assign home_url = company_url />
</#if>

<#if is_impersonated>
    <#assign do_as_user_id = paramUtil.getString(request, "doAsUserId") />
    <#assign home_url = httpUtil.addParameter(home_url, "doAsUserId", do_as_user_id) />
</#if>

<nav class="${nav_css_class} navbar navbar-default" id="navigation" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".site-navigation" aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
           
            <a class="navbar-brand ${logo_css_class}" href="${home_url}" title="<@liferay.language_format arguments="${site_name}" key="go-to-x" />">
            
                <#--  
                <img alt="${logo_description}" src="${company_logo}?v.1" />
                -->
                
                <#-- <#if show_site_name>  -->
                    <span class="brand-name site-name" title="<@liferay.language_format arguments="${company_name}" key="go-to-x" />">
                        ${company_name}
                    </span>
                <#-- </#if> -->
            </a>

        </div>
 
        <#if layout.isPublicLayout() >
            <ul aria-label="<@liferay.language key="site-pages" />" class="collapse nav navbar-collapse navbar-nav navbar-right site-navigation" role="menubar">
                <#list nav_items as nav_item>
                    <#assign
                        data_toggle = ""
                        has_children = false 
                        nav_item_attr_has_popup = ""
                        nav_item_attr_selected = ""
                        nav_item_css_class = ""
                        nav_item_layout = nav_item.getLayout()
                        nav_link_css_class = ""
                    />
                    
                    <#if nav_item.hasChildren()>
                        <#assign data_toggle = "data-toggle=\"dropdown\"" />                        
                        <#assign has_children = true />                        
                        <#assign nav_item_css_class = "dropdown"/>
                        <#assign nav_link_css_class = "dropdown-toggle"/>
                    </#if>
                    
        
                    <#if nav_item.isSelected()>
                        <#assign
                            nav_item_attr_has_popup = "aria-haspopup='true'"
                            nav_item_attr_selected = "aria-selected='true'"
                            nav_item_css_class = nav_item_css_class + " active"
                        />
                    </#if>
                    
                    <li ${nav_item_attr_selected} class="${nav_item_css_class}" id="layout_${nav_item.getLayoutId()}" role="presentation">
                        <a aria-labelledby="layout_${nav_item.getLayoutId()}" ${nav_item_attr_has_popup} href="${nav_item.getURL()}" ${nav_item.getTarget()} role="menuitem">
                            <span><@liferay_theme["layout-icon"] layout=nav_item_layout /> ${nav_item.getName()}</span>
                        </a>
                        <#if has_children>
                            <a aria-labelledby="layout_${nav_item.getLayoutId()}" class="${nav_link_css_class}" ${nav_item_attr_has_popup} ${data_toggle} href="${nav_item.getURL()}" ${nav_item.getTarget()} role="menuitem">
                                <span class="icon-angle-down"></span>
                            </a>
                            <ul class="dropdown-menu" role="menu">
                                <#list nav_item.getChildren() as nav_child>
                                    <#assign
                                        nav_child_attr_selected = ""
                                        nav_child_css_class = ""
                                    />
        
                                    <#if nav_item.isSelected()>
                                        <#assign
                                            nav_child_attr_selected = "aria-selected='true'"
                                            nav_child_css_class = "selected"
                                        />
                                    </#if>
        
                                    <li ${nav_child_attr_selected} class="${nav_child_css_class}" id="layout_${nav_child.getLayoutId()}" role="presentation">
                                        <a aria-labelledby="layout_${nav_child.getLayoutId()}" href="${nav_child.getURL()}" ${nav_child.getTarget()} role="menuitem">${nav_child.getName()}</a>
                                    </li>
                                </#list>
                            </ul>
                        </#if>                        
                    </li>
                                  
                </#list>

                <li>
                    <#assign VOID = freeMarkerPortletPreferences.setValue("portletSetupPortletDecoratorId", "barebone") />        
                                        
                    <@liferay_portlet["runtime"]
                        defaultPreferences="${freeMarkerPortletPreferences}"
                        portletProviderAction=portletProviderAction.VIEW
                        instanceId="NAVIGATION_LANGUAGE"
                        portletName="com_liferay_site_navigation_language_web_portlet_SiteNavigationLanguagePortlet" />
            
                    <#assign VOID = freeMarkerPortletPreferences.reset() />
                </li>

                <#if theme_display.isSignedIn() >
                    <#if user.hasPrivateLayouts()>
                        <li>
                            <a class="btn btn-info btn-my-account" href="${user.getDisplayURL(theme_display, true)}">
                                <span class="icon-home hidden-xs hidden-md hidden-lg"></span>
                                <span class="hidden-sm"><@liferay.language key="my-account" /></span>
                            </a>
                        </li>
                    </#if>
                </#if>
            </ul>
        <#else>
            
            <ul class="collapse my-account nav navbar-collapse navbar-nav navbar-right" role="menubar">
                <li>
                    <#if user.hasPrivateLayouts()>
                                               
                        <#if theme_display.scopeGroupId == user.groupId >
                            <a href="${user.getDisplayURL(theme_display, true)}">
                                <span class="user-name">${user.fullName}</span>
                            </a>
                        <#else>
                            <a class="btn btn-info btn-my-account" href="${user.getDisplayURL(theme_display, true)}">
                                <span><@liferay.language key="my-account" /></span>
                            </a>
                        </#if>
                    <#else>
                        <span class="user-name text-muted">${user.fullName}</span>                
                    </#if>
                </li>
            </ul>
        </#if> 
    </div>
</nav>
