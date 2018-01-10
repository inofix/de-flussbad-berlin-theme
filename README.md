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
1. The deployable WAR is found at **$WORKSPACE/wars/de-flussbad-berlin-theme/build/libs/de-flussbad-berlin-theme.war**

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

By default, the serviceLocator is disabled in the portal. In order to activate the serviceLocator go to: 

<pre>
 Control Panel -> Configuration -> System Settings 
 Search: Freemarker
 Choose: Freemarker Engine
 Remove: serviceLocator from restricted variables.
</pre>

Restart the server.

## How To Contribute

1. Fork this repository to your individual github account.
1. Clone your personal fork to your local machine.
1. Use feature branches to work on new features or known issues.
1. Merge finished features into your individual master branch and 
1. create pull-requests, to contribute your solutions to the inofix master branch.

**Stay up-to-date**

1. Change the current working directory to your local project.
1. Configure https://github.com/inofix/de-flussbad-berlin-theme as additional upstream remote (see: https://help.github.com/articles/configuring-a-remote-for-a-fork/)
1. Sync inofix-master with your individual fork (see: https://help.github.com/articles/syncing-a-fork/): 
1. Fetch upstream/master to your local copy: `git fetch upstream` 
1. Check out your fork's local 'master' branch: `git checkout master`
1. Merge the changes from 'upstream/master' into your local master branch. This brings your fork's master branch into sync with the upstream repository, without losing your local changes: `git merge upstream/master`
1. Push merged master to your individual github account and 
1. create a pull-request, to contribute your solution to the inofix master branch.

## How To Test

TODO

