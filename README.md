# HMPPS Orb [![CircleCI Build Status](https://circleci.com/gh/ministryofjustice/hmpps-circleci-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/ministryofjustice/hmpps-circleci-orb) [![Orb Version Badge](https://badges.circleci.com/orbs/ministryofjustice/hmpps.svg)](https://circleci.com/orbs/registry/orb/ministryofjustice/hmpps) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/ministryofjustice/hmpps-circleci-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

HMPPS circleci orb - reusable config for hmpps teams. If you would like to start using and contribute to this project please contact the [#hmpps_dev](https://mojdt.slack.com/archives/C69NWE339) channel in slack or raise an issue in this project.

## Usage

Example use-cases are provided on the orb [registry page](https://circleci.com/orbs/registry/orb/ministryofjustice/hmpps#usage-examples). Source for these examples can be found within the `src/examples` directory.

## Release Notes

##### [8.x](release-notes/8.x.md)
##### [7.x](release-notes/7.x.md)
##### [6.x](release-notes/6.x.md)

## Known Issue

You may get this error when pushing a new PR:
```
The dev version of ministryofjustice/hmpps@dev:alpha has expired. Dev versions of orbs are only valid for 90 days after publishing.
```

If you see this error, you need to publish a dev:alpha version manually. The fix is to run this:

```
circleci orb pack ./src | circleci orb validate -
circleci orb pack ./src | circleci orb publish -  ministryofjustice/hmpps@dev:alpha
```

Once you do this you will need to run the pipeline again.

You may also get an error if the `dev:alpha` version is out of date and there are config changes in the latest orb that aren't in the dev alpha version.

## Slack notifications

This orb is dependant on the `circleci/slack` orb. To allow slack messages to be sent, a slack app has been created as per the instructions here: <https://github.com/CircleCI-Public/slack-orb/wiki/Setup>

To see the slack apps configuration go here <https://api.slack.com/apps/> and find the app called `HMPPS CircleCI`. From here you can find the `OAuth & Permissions` page. The access token for this app needs to be exposed as environment variable `SLACK_ACCESS_TOKEN` to the circleci job - please read the linked docs for more details. Including this environment variable can be done by including the circleci context `hmpps-common-vars` on the circleci workflow.

## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/ministryofjustice/hmpps) - The official registry page of this orb for all versions, executors, commands, and jobs described.  
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.  

### How To Contribute

We welcome [issues](https://github.com/ministryofjustice/hmpps-circleci-orb/issues) to and [pull requests](https://github.com/ministryofjustice/hmpps-circleci-orb/pulls) against this repository!

#### Testing your changes

You can define an inline orb in your project's circleci config. [Documentation](https://circleci.com/docs/reusing-config/#writing-inline-orbs) here and a [working example here](https://app.circleci.com/projects/github/ministryofjustice/hmpps-person-record/config/?branchName=CPR-330&pipelineNumber=1772) 

#### Publish a new production version:
* Consider adding to the release notes. Especially for breaking changes.
* When ready to publish a new production version, create a PR. The Git Subject (commit message of the most recent commit - `git log -1 --pretty=%s.`) should include `[semver:patch|minor|release|skip]` to indicate the type of release.
* On merge, the release will be published to the orb registry automatically.

For further questions/comments about this or other orbs, visit the Orb Category of [CircleCI Discuss](https://discuss.circleci.com/c/orbs).
