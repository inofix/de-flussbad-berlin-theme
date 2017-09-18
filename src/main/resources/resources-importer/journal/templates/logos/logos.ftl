<#--
    logos.ftl: Format the logos structure
    
    Created:    2015-09-02 18:08 by Christian Berndt
    Modified:   2017-09-18 19:01 by Christian Berndt
    Version:    1.0.0
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<#if logo.getSiblings()?has_content>
    <div class="logos">
        <div class="container">
            <div class="row">
                <div class="col-sm-12">            
                    <#list logo.getSiblings() as cur_logo>
                        <#if cur_logo.getData()?has_content>
                            <a href="${cur_logo.link.getData()}" target="_blank">
                                <img src="${cur_logo.getData()}"/>
                            </a>
                        </#if>
                    </#list>
                </div>
            </div>
        </div>
    </div>
</#if>
