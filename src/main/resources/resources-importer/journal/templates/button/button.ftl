<#--
    button.ftl: Format the button structure

    Created:    2017-09-19 16:24 by Christian Berndt
    Modified:   2017-09-19 16:24 by Christian Berndt
    Version:    1.0.0

    Please note: Although this template is stored in the
    site's context it's source is managed via git. Whenever you
    change the template online make sure that you commit your
    changes to the flussbad-modules repo, too.
-->
<div class="container button">
    <div class="row">
        <div class="col-sm-12">
            <a class="btn btn default" href="${target.getFriendlyUrl()}">
                ${target.label.getData()}
            </a>
        </div>
    </div>
</div>