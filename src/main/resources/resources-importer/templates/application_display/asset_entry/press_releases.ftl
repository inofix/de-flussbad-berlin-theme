<#--
    press_releases.ftl: Loop over a list of asset-entries and
    format them in press-release fashion.
    
    Created:    2015-11-07 09:32 by Christian Berndt
    Modified:   2017-09-15 23:14 by Christian Berndt
    Version:    1.0.4
-->

<#assign dateFormat = "dd MMM yyyy" />
<#assign journalArticleService = serviceLocator.findService("com.liferay.journal.service.JournalArticleLocalService")>
<#assign languageId = languageUtil.getLanguageId(request) >

<#if entries?has_content>
<div class="press-releases" >
    <div class="container">
        <div class="row">
            <div class="col-sm-8 col-sm-offset-1">
                <h3><@liferay.language key="press-releases" /></h3>
                <#list entries as curEntry>   
                    <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK()) />
                    <#assign document = saxReaderUtil.read(article.getContentByLocale(languageId)) />
                    <#assign title = document.valueOf("//dynamic-element[@name='headline']/dynamic-content/text()") />
                    <#assign publishDate = getterUtil.getLong(document.valueOf("//dynamic-element[@name='publishDate']/dynamic-content/text()")) />
                    <#assign assetRenderer = curEntry.getAssetRenderer() />
                    <#assign viewURL = "#">
                    <#-- TODO 
                    <#assign viewURL = assetRenderer.getURLViewInContext(renderRequest, renderResponse, null) />
                    -->
                    <div class="item">
                        <div class="publish-date">${dateUtil.getDate(publishDate?number_to_date, dateFormat, locale)}</div>
                        <h3><a href="${viewURL}" title="<@liferay.language key="read-more" />">${title}</a></h3>
                        <#--
                        <div class="asset-more"><a href="${viewURL}"><@liferay.language key="read-more" /></a></div>
                        -->
                    </div>
                </#list>
            </div>
        </div>
    </div>
</#if>