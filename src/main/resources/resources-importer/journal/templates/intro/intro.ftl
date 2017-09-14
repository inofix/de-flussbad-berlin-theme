<#--
    intro.ftl: Format the intro structure
    
    Created:    2015-08-28 17:52 by Christian Berndt
    Modified:   2017-09-14 15:45 by Christian Berndt
    Version:    1.1.3
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->

<#assign cssClass = "" />
<#assign style = "background: white;" />
<#assign hasKeyVisual = false />
<#assign hasGradient = true />
<#assign layoutLocalService = serviceLocator.findService("com.liferay.portal.kernel.service.LayoutLocalService")>
<#-- with virtualhost configured -->
<#assign prefix = "" />
    
<#-- request['theme-display'] is not available in search -->
<#if request['theme-display']?? >

    <#assign themeDisplay = request['theme-display'] />
    <#assign plid = themeDisplay['plid'] />
    
    <#assign layout = layoutLocalService.getLayout(plid?number) />
    
    <#assign currentURL = request.attributes['CURRENT_URL']>
    <#assign pathFriendlyURL = themeDisplay['path-friendly-url-public'] />
    <#assign groupURL = layout.group.friendlyURL />
    <#assign pathAndGroupURL = pathFriendlyURL + groupURL />
        
    <#-- without virtualhost configured -->
    <#if currentURL?starts_with(pathFriendlyURL)>
        <#assign prefix = pathAndGroupURL />
    </#if>     
    
</#if>
    
<#if useGradient?? >
    <#if getterUtil.getBoolean(useGradient.getData())>
        <#assign hasGradient = true  />
    <#else>
        <#assign hasGradient = false  />        
    </#if>
</#if>


<#-- remove with-image when custom.css is updated -->
<#if background??>
    <#if background.getData()?has_content>    
        <#assign cssClass = "with-image" />
        <#assign hasKeyVisual = true />
        <#if hasGradient>
            <#assign style = "background-image: linear-gradient( rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)), url('${background.getData()}&imageThumbnail=3');" />
        <#else>
             <#assign style = "background-image: url('${background.getData()}&imageThumbnail=3');" />
        </#if>        
    </#if>
</#if>

<#if backgroundColor??>
    <#assign cssClass = "${cssClass}" + " " + "${backgroundColor.getData()}" />
</#if>

<div class="intro ${cssClass}">

    <#if hasKeyVisual>
        <div class="keyvisual" style="${style}">
            <div class="claim container">
                <div class="row">
                    <div class="col-sm-6 col-sm-offset-3">
                        <#if link.getData()?has_content >
                        
                            <#assign target = layoutLocalService.getLayout(groupId?number, false, link.getData()?number) />                                        
                            <#assign targetURL = prefix + target.getFriendlyURL(locale) />
                                                   
                            <a href="${targetURL}" title="${label.getData()}">
                                <h1>${headline.getData()}</h1>
                            </a>
                        <#else>
                            <h1>${headline.getData()}</h1>
                        </#if>
                    </div>
                </div>
            </div>
        </div>
    <#else>
        <div class="claim container">
            <div class="col-sm-6 col-sm-offset-3">
                <h1>${headline.getData()}</h1>
            </div>
        </div>    
    </#if>

    <div class="abstracts container">

        <#if clubLink??>
            <#if clubLink.getData()?has_content>
                <div class="row">
                    <div class="col-sm-4 offset-sm-8">
                        <div class="pull-right">
                        
                            <#assign target = layoutLocalService.getLayout(groupId?number, false, clubLink.getData()?number) />                                        
    
                            <#assign targetURL = prefix + target.getFriendlyURL(locale) />
                                
                            <a class="club-link" href="${targetURL}" title="${languageUtil.get(locale, "get-involved")}"><span>${languageUtil.get(locale, "get-involved")}</span></a>
                        </div>
                    </div>
                </div>
            </#if>
        </#if>
        
        <#if caption.getSiblings()?has_content>
            <div class="row">
                <#assign i = 0 />
                <#list caption.getSiblings() as cur_caption>
                    <#if (i < 3) >                   
                        <div class="col-sm-4">
                            <#if cur_caption.getData()?has_content>
                                <div class="abstract abstract-${i}">
                                    <h3>${cur_caption.getData()}</h3>
                                    <h2>${cur_caption.claim.getData()}</h2>
                                    <p>${cur_caption.abstract.getData()}</p>
                                    <#if cur_caption.abstractLink.getData()?has_content>
                                    
                                        <#assign target = layoutLocalService.getLayout(groupId?number, false, cur_caption.abstractLink.getData()?number) />                                        
                                    
                                        <#assign targetURL = prefix + target.getFriendlyURL(locale) />
                                                        
                                        <div>
                                            <a href="${targetURL}" class="btn btn-default" title="${cur_caption.abstractLabel.getData()}">${cur_caption.abstractLabel.getData()}</a>
                                        </div>
                                    </#if>
                                </div>
                            </#if>
                        </div>
                        <#assign i = i+1/>
                    </#if>
                </#list>
            </div>
        </#if> 
        
    </div>

    <#if link.getData()?has_content && !hasKeyVisual>
        <div class="link">
            <a href="${link.getData()}" class="btn btn-default" title="${label.getData()}">${label.getData()}</a>
        </div>
    </#if>

</div>
