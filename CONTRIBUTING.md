# ONCO Contributing Guidelines

We are using [git](https://git-scm.com/doc) as version control and [GitHub](https://docs.github.com/en/get-started) as repository hosting

## Aritifacts
* [ONCO UI](./ui/)
* [ONCO API](./api/)
* [ONCO Prototype](./Prototype/)
* [ONCO Raw Models](./models/)

## Contributing Workflow

* Create a branch following the branching conventions
* Make changes to the code, test locally, commit and push to remote
* Create a pull request and request review.
* Address review comments
* Re-request review

## Branching Convention

### Main Branches

* master
* dev
* hotfix

### Gitflow

* A dev branch is created from master
* Feature branches are created from dev
* When a feature is complete it is merged into the deev branch
* If an issue in master is detected a hotfix branch is created from master
* Once the hotfix is complete it is merged to both dev and master

### Branching Model for Development

| prefix | usage |  
|--|--|  
| feature/ | Feature branches are used for specific feature work or improvements. They generally branch from, and merge back into, the development branch, by means of pull requests. |  
| bugfix/ | Bugfix branches are typically used to fix release branches. |  
| hotfix/ | Hotfix branches are used to quickly fix the production branch without interrupting changes in the development branch. |  

### Branch Naming Conventions

Eg: `feature/my-feature-branch`

1. Add the suitable branch prefix (Eg: `feature/`)
3. Add a short description using lower case letters and dash as the separator. Avoid long descriptive names. (Eg: `my-feature-branch`)

## Style Guide/ Coding Conventions

TBD [See Atom's example](https://github.com/atom/atom/blob/master/CONTRIBUTING.md#styleguides)