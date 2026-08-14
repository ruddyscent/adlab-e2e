# Commit Message Guidelines

These rules apply to every commit created in this repository.

## Title

Use a Conventional Commits prefix in every commit title:

```text
<type>(optional-scope): <imperative summary>
```

Allowed types are:

- `feat`: add or change user-facing functionality
- `fix`: correct a defect
- `docs`: change documentation only
- `refactor`: restructure code without changing behavior
- `test`: add or update tests
- `build`: change build files or dependencies
- `ci`: change continuous-integration configuration
- `perf`: improve performance
- `style`: make formatting-only changes
- `chore`: perform maintenance not covered by another type
- `revert`: revert an earlier commit

Keep the summary concise, use the imperative mood, and do not end it with a period.

## Description

Every non-trivial commit must include a commit body separated from the title by a blank line. The body must explain:

- what changed; and
- why the change was necessary or which problem it solves.

A commit is trivial only when it changes no runtime behavior, build behavior, public interface, dependency, configuration, or workflow. Examples include correcting a typo, adjusting whitespace, or rewording a comment without changing its meaning. When in doubt, treat the commit as non-trivial and write a description.

For breaking changes, add a `BREAKING CHANGE:` footer describing the impact and required migration.
