# de-flussbad-berlin-theme

The Bootstrap 3 based edition of the flussbad-theme

## Tooling

Liferay IDE 3.1.1 GA2 from https://sourceforge.net/projects/lportal/files/Liferay%20IDE/3.1.1%20GA2/

## How To Build

1. Install blade: `curl https://raw.githubusercontent.com/liferay/liferay-blade-cli/master/installers/local | sh`
1. Create a liferay workspace: `WORKSPACE=my-workspace; blade init $WORKSPACE`
1. `cd $WORKSPACE/wars`
1. `git clone https://github.com/inofix/de-flussbad-berlin-theme.git`
1. `cd de-flussbad-berlin-theme`
1. `gradle war`
1. The deployable WAR is found at $WORKSPACE/wars/de-flussbad-berlin-theme/build/libs/de-flussbad-berlin-theme.war

## How To Deploy

Make sure you have configured the required thumbnail-sizes in portal-ext.properties: 

<pre>
  #
  # custom-thumbnail configuration for document library
  #
  dl.file.entry.thumbnail.custom1.max.height=600
  dl.file.entry.thumbnail.custom1.max.width=600
  dl.file.entry.thumbnail.custom2.max.height=1440
  dl.file.entry.thumbnail.custom2.max.width=1440
</pre>

## How To Contribute

TODO

