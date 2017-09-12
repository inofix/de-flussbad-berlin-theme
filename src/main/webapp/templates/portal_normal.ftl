<#--
    portal_normal.ftl: base template of the flussbad-theme.
    
    Created:    2017-09-07 10:57 by Christian Berndt
    Modified:   2017-09-12 19:12 by Christian Berndt
    Version:    1.0.1
-->

<!DOCTYPE html>

<#include init />

<#assign full_width = getterUtil.getBoolean(themeDisplay.getThemeSetting("full-width"), false) />

<#assign wrapper_class = "container"/>

<#if full_width>
    <#assign wrapper_class = "container-fluid full-width"/>
</#if>

<html class="${root_css_class}" dir="<@liferay.language key="lang.dir" />" lang="${w3c_language_id}">

    <head>
        <title>${the_title} - ${company_name}</title>
        
        <meta content="initial-scale=1.0, width=device-width" name="viewport" />
        
         <link href="https://fonts.googleapis.com/css?family=Amatic+SC:400,700&amp;subset=latin-ext" rel="stylesheet">
        
        <@liferay_util["include"] page=top_head_include />
    
    </head>

    <body class="${css_class}">
    
    <@liferay_ui["quick-access"] contentId="#main-content" />
    
    <@liferay_util["include"] page=body_top_include />
    
    <@liferay.control_menu />
        
        <header id="banner" role="banner">
            <#if (has_navigation && is_setup_complete) || 
                 (is_impersonated && has_navigation) >
                 
                <#include "${full_templates_path}/navigation.ftl" />
                
            </#if>
        </header>
        
        <div class="${wrapper_class}" id="wrapper">
    
            <section id="content">
            
                <#if selectable>
                    <@liferay_util["include"] page=content_include />
                <#else>
                    ${portletDisplay.recycle()}
            
                    ${portletDisplay.setTitle(the_title)}
            
                    <@liferay_theme["wrap-portlet"] page="portlet.ftl">
                        <@liferay_util["include"] page=content_include />
                    </@>
                </#if>
            </section>
            
        </div>
        
        <footer id="footer" role="contentinfo">
        
            <div class="container">
            
                <div class="row">
                
                    <div class="col-sm-6">
                        &copy; 2015-2017 <a href="http://www.flussbad-berlin.de" target="_blank">Flussbad Berlin e.V.</a>
                    </div>

                    <div class="col-sm-6">
                    
                        <#if !is_signed_in>
                            <a data-redirect="${is_login_redirect_required?string}" href="${sign_in_url}" id="sign-in" rel="nofollow">${sign_in_text}</a>
                        <#elseif sign_out_url??> <#-- sign_out_url is not available in impersonate mode -->
                            <a href="${sign_out_url}" id="sign-out" rel="nofollow" title="<@liferay.language key="sign-out" />"><@liferay.language key="sign-out" /></a>
                        </#if>
                    </div>                
                
                </div>
            </div>
        </footer>
        
        <@liferay_util["include"] page=body_bottom_include />
        
        <@liferay_util["include"] page=bottom_include />
        
        <!-- inject:js -->
        <!-- endinject -->
    
    </body>

</html>
