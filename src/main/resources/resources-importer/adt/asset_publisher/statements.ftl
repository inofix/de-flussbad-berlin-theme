<#--
    statements.ftl: Display a list of statements in a scrollview-carousel.
    
    Created:    2015-10-13 18:27 by Christian Berndt
    Modified:   2017-09-12 17:35 by Christian Berndt
    Version:    1.0.4
-->

<#assign journalArticleService = serviceLocator.findService("com.liferay.journal.service.JournalArticleLocalService")>

<#assign cssClass = "gray-green">

<div class="statements ${cssClass}">
    <#if entries?has_content>
        <ul class="slides">
        <#list entries as curEntry>
            <li class="item">

                <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK())>
                <#assign content = "TODO: retrieve content from article"/>
                <#--  
                <#assign content = journalContentUtil.getContent(themeDisplay.getScopeGroupId(), article.getArticleId(), article.getTemplateId(), themeDisplay.getLanguageId(), themeDisplay)>
                -->
                ${content}

            </li>
        </#list>
        </ul>
    </#if>
</div>
