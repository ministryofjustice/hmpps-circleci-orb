# hmpps Orb [![CircleCI Build Status](https://circleci.com/gh/ministryofjustice/hmpps-circleci-orb.svg?style=shield "CircleCI Build Status")](https://circleci.com/gh/ministryofjustice/hmpps-circleci-orb) [![CircleCI Orb Version](https://img.shields.io/badge/endpoint.svg?url=https://badges.circleci.io/orb/ministryofjustice/hmpps)](https://circleci.com/orbs/registry/orb/ministryofjustice/hmpps) [![GitHub License](https://img.shields.io/badge/license-MIT-lightgrey.svg)](https://raw.githubusercontent.com/ministryofjustice/hmpps-circleci-orb/master/LICENSE) [![CircleCI Community](https://img.shields.io/badge/community-CircleCI%20Discuss-343434.svg)](https://discuss.circleci.com/c/ecosystem/orbs)

HMPPS circleci orb - reusable config for hmpps teams. If you would like to start using and contribute to this project please contact the DPS team.

## Usage

Example use-cases are provided on the orb [registry page](https://circleci.com/orbs/registry/orb/ministryofjustice/hmpps#usage-examples). Source for these examples can be found within the `src/examples` directory.

## Known Issue

You may get this error when pushing a new PR, 

```
The dev version of ministryofjustice/hmpps@dev:alpha has expired. Dev versions of orbs are only valid for 90 days after publishing.
```

If you see this error, you need to publish a dev:alpha version manually. The fix is to run this:

```
circleci orb pack ./src | circleci orb validate -
circleci config pack ./src | circleci orb publish -  ministryofjustice/hmpps@dev:alpha
```


## Resources

[CircleCI Orb Registry Page](https://circleci.com/orbs/registry/orb/ministryofjustice/hmpps) - The official registry page of this orb for all versions, executors, commands, and jobs described.  
[CircleCI Orb Docs](https://circleci.com/docs/2.0/orb-intro/#section=configuration) - Docs for using and creating CircleCI Orbs.  

### How To Contribute

We welcome [issues](https://github.com/ministryofjustice/hmpps-circleci-orb/issues) to and [pull requests](https://github.com/ministryofjustice/hmpps-circleci-orb/pulls) against this repository!

To publish a new production version:
* Create a PR to the `Alpha` branch with your changes. This will act as a "staging" branch.
* When ready to publish a new production version, create a PR from `Alpha` to `master`. The Git Subject should include `[semver:patch|minor|release|skip]` to indicate the type of release.
* On merge, the release will be published to the orb registry automatically.

For further questions/comments about this or other orbs, visit the Orb Category of [CircleCI Discuss](https://discuss.circleci.com/c/orbs).

