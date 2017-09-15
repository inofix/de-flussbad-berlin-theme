<#--
    introduction.ftl: Format the introduction structure
    
    Created:    2015-10-15 23:58 by Christian Berndt
    Modified:   2017-09-15 23:35 by Christian Berndt
    Version:    1.1.1
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#assign backURL = "" />
<#assign currentURL = "">
<#assign groupURL = "" />
<#assign layout = ""/>
<#assign namespace = "" />
<#assign parentPlid = 0 >
<#assign pathFriendlyURL = "" />
<#assign plid = "0" />
<#assign prefix = "" />
<#assign themeDisplay = "" />
<#assign title = "" />

<#-- request['theme-display'] is not available in search -->
<#if request['theme-display']?? >
    <#assign namespace = request['portlet-namespace'] />
    <#assign themeDisplay = request['theme-display'] />
    <#assign plid = themeDisplay['plid'] />
    <#assign pathFriendlyURL = themeDisplay['path-friendly-url-public'] />
</#if>

<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService")>

<#if plid?number gt 0 >
    <#assign layout = layoutLocalService.getLayout(plid?number) />
    <#assign backURL = prefix + layout.getFriendlyURL(locale) />
    <#assign groupURL = layout.group.friendlyURL />
    <#assign parentPlid = layout.getParentPlid() >
    <#assign title = layout.getName(locale) /> 
</#if>


<#if request.attributes?? >
    <#assign currentURL = request.attributes['CURRENT_URL']/>
</#if>

<#assign pathAndGroupURL = pathFriendlyURL + groupURL />

<#-- without virtualhost configured -->
<#if currentURL?starts_with(pathFriendlyURL)>
    <#assign prefix = pathAndGroupURL />
</#if>

<#if parentPlid gt 0>
    <#assign parentLayout = layoutLocalService.getLayout(parentPlid) />
    <#assign title = parentLayout.getName(locale) />
    <#assign backURL = prefix + parentLayout.getFriendlyURL() />
</#if>

<#assign style = "" />
<#assign displayCategories = false />
<#assign displayToc = false />
<#assign displayPointer = false />
<#assign fullWidth = false />

<#if keyVisual??>
    <#if keyVisual.getData()?has_content>
        <#assign style = "background-image: url('${keyVisual.getData()}&imageThumbnail=3');" />
    </#if>
</#if>

<#if showToc?? >
    <#if showToc.getData()?has_content>
        <#if getterUtil.getBoolean(showToc.getData())>
            <#assign displayToc = getterUtil.getBoolean(showToc.getData()) />
        </#if>
    </#if>
</#if>

<#if showCategories?? >
    <#if showCategories.getData()?has_content>
        <#if getterUtil.getBoolean(showCategories.getData())>
            <#assign displayCategories = getterUtil.getBoolean(showCategories.getData()) />
        </#if>
    </#if>
</#if>

<#if showPointer?? >
    <#if showPointer.getData()?has_content>
        <#if getterUtil.getBoolean(showPointer.getData())>
            <#assign displayPointer = getterUtil.getBoolean(showPointer.getData()) />
        </#if>
    </#if>
</#if>

<#if displayFullWidth?? >
    <#if displayFullWidth.getData()?has_content>
        <#if getterUtil.getBoolean(displayFullWidth.getData())>
            <#assign fullWidth = getterUtil.getBoolean(displayFullWidth.getData()) />
        </#if>
    </#if>
</#if>

<#assign cssStyle = "span8 offset2">

<#if fullWidth >
    <#assign cssStyle = "span10 offset1">
<#elseif displayToc >
    <#assign cssStyle = "span8 offset1">
</#if>

<div class="introduction with-keyvisual">
    <div class="keyvisual" style="${style}"></div>
    <div class="container">
        <div class="content ${cssStyle}">
        
            <#if displayCategories >
                <h3 class="category"><a href="${backURL}">${title}</a></h3>
            </#if>
            
            <h1>${headline.getData()}</h1>
            <p class="lead">${teaser.getData()}</p>
            <div class="section">
                <div class="section-body">${description.getData()}</div>
            </div>
            
            <#if displayPointer >
                <h3 class="category">Alle Artikel zum Thema ${layout.getName(locale)}</h3>
                <div class="pointer"><span class="icon-arrow-down"></span></div>
            </#if>
            
        </div> <#-- /.content -->
        
        <#if displayToc>
        
            <div class="span3">
                <div class="toc">
                    <ul class="nav nav-list">                        
                        <#-- LIs are appended via js -->
                    </ul>
                </div> <#-- / .toc -->
            </div> <#-- / .span3 -->
        </#if>        
    </div> <#-- /.container -->
</div> <#-- /.introduction -->