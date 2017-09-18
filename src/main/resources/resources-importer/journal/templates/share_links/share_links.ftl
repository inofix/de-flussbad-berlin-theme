<#--
    share_links.ftl: Format the share_links structure
    
    Created:    2015-09-29 11:31 by Christian Berndt
    Modified:   2017-09-18 11:54 by Christian Berndt
    Version:    1.0.0
    
    Please note: Although this template is stored in the 
    site's context it's source is managed via git. Whenever you 
    change the template online make sure that you commit your 
    changes to the flussbad-modules repo, too.
-->
<div class="share-links">
    <ul>
        <#if link.getSiblings()?has_content>
            <#list link.getSiblings() as cur_link>
                <li>
                    <a href="${cur_link.getData()}" target="_blank">
                        <span class="circle"><span class="${cur_link.icon.getData()}"></span></span>
                    </a>
                </li>
            </#list>
        </#if>
    </ul>
</div>