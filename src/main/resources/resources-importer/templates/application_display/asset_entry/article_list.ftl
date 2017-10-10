<#--
    article_list.ftl: Display a set of articles in a reloadable list.
    
    Created:    2017-09-14 16:23 by Christian Berndt
    Modified:   2017-10-10 13:22 by Christian Berndt
    Version:    1.0.1
-->

<#assign journalArticleService = serviceLocator.findService("com.liferay.journal.service.JournalArticleLocalService")>

<#assign language_id = languageUtil.getLanguageId(locale) />

<#function value_of docXml field language_id>
    <#local default_language_id = docXml.valueOf("/root/@default-locale") />
    <#local value = docXml.valueOf("//dynamic-element[@name='" + field + "']/dynamic-content[@language-id='"+ language_id + "']/text()") />
    <#if !value?has_content>
        <#local value = docXml.valueOf("//dynamic-element[@name='" + field + "']/dynamic-content[@language-id='"+ default_language_id + "']/text()") />
    </#if>
    <#return value />
</#function>

<div class="articles" >
    <#if entries?has_content>
        <div class="container">
            <#list entries as curEntry>
                <div class="row">
                
                    <#assign content = "" />
                    
                    <#if "com.liferay.journal.model.JournalArticle" == curEntry.className >
                        <#assign article = journalArticleService.getLatestArticle(curEntry.getClassPK()) />
                        <#assign xml = saxReaderUtil.read(article.content) />
                        
                        <#assign displayDate = curEntry.publishDate?string('dd. MMM. yyyy') />
                        <#assign articleDate = value_of(xml, "date", language_id) />
                        
                        <#assign summary = curEntry.getSummary(locale) />
                        <#assign article_summary = value_of(xml, "summary", language_id) />
                        <#if article_summary?has_content>
                            <#assign summary = article_summary />
                        </#if>
                        
                        <#assign title = curEntry.getTitle(locale) />
                        <#assign article_title = value_of(xml, "title", language_id) />
                        <#if article_title?has_content>
                            <#assign title = article_title />
                        </#if>
                                                
                        <div class="col-sm-4">
                            <div class="asset-metadata">
                                <span class="date">${displayDate}</span> 
                                <span class="categories">TODO: Categories</span>
                            </div>
                        </div>
                        
                        <div class="col-sm-8">
                            <a href="#"><h1 class="title">${title}</h1></a>
                        </div>
    
                    <#else>
                        <span class="alert alert-danger"><strong>${curEntry.className}</strong> is not supported by the article_list display template.</alert>
                    </#if>
                </div>
                
                <#if summary?has_content>
                    <div class="row">
                        <div class="col-sm-8 col-sm-offset-4">
                            <#if summary?has_content>
                                <div class="summary">${summary}</div>
                            </#if>
                        </div>
                    </div>
                </#if>
                
                <div class="row">
                    <div class="col-sm-8 col-sm-offset-4">
                        <div class="share-buttons">              
                            <span class="label"><@liferay.language key="tell-others" /></span>
                            <a href="#"><span class="icon icon-facebook"></span></a>
                            <a href="#"><span class="icon icon-twitter"></span></a>
                            <a href="#"><span class="icon icon-envelope-alt"></span></a>
                        </div>
                    </div>
                </div>
                
                <#--  
                <div class="row">
                    <div class="col-sm-8 col-sm-offset-4">
                        <textarea>${xml.asXML()}</textarea>
                    </div>
                </div>
                -->
                
            </#list>
        </div>
    </#if>
</div>
