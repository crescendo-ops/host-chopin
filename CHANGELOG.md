# Changelog

## 0.0.1 (2026-03-10)


### Features

* **repo:** initial split from home-infra (chopin) ([f0713b1](https://github.com/crescendo-ops/host-chopin/commit/f0713b1db02b992701c8751d4bae5643fd184a18))


### Bug Fixes

* **ci:** accept prerelease release-pr titles for beta base version ([#8](https://github.com/crescendo-ops/host-chopin/issues/8)) ([0bdbf6a](https://github.com/crescendo-ops/host-chopin/commit/0bdbf6a90e57bc4c7b39faed181670525884524a))
* **ci:** align beta tag target and release-asset triggering ([#24](https://github.com/crescendo-ops/host-chopin/issues/24)) ([1791876](https://github.com/crescendo-ops/host-chopin/commit/1791876f963a1eb039b46b5f6d1ea5ed533134f1))
* **ci:** align release-please inputs and beta version fallback ([#7](https://github.com/crescendo-ops/host-chopin/issues/7)) ([24dca1d](https://github.com/crescendo-ops/host-chopin/commit/24dca1d9198bce0d99981b6e191b2486c80fb542))
* **ci:** dispatch release asset workflow after beta publish ([#11](https://github.com/crescendo-ops/host-chopin/issues/11)) ([d932f61](https://github.com/crescendo-ops/host-chopin/commit/d932f616ebd707169a6e80a26ea953cba05b7de3))
* **ci:** fallback beta notes to open release PR body ([#16](https://github.com/crescendo-ops/host-chopin/issues/16)) ([0a63be3](https://github.com/crescendo-ops/host-chopin/commit/0a63be34ea585fa4cb21b2998d53468a2ab73f38))
* **ci:** fix prerelease workflow if syntax ([#3](https://github.com/crescendo-ops/host-chopin/issues/3)) ([b2aa55b](https://github.com/crescendo-ops/host-chopin/commit/b2aa55b2994bf0ec81e37b2ca3c1eee6cf9f7b2e))
* **ci:** make beta releases clearly labeled ([#25](https://github.com/crescendo-ops/host-chopin/issues/25)) ([b613753](https://github.com/crescendo-ops/host-chopin/commit/b613753dc8df78c285ca82585031f996379c3aab))
* **ci:** pass explicit repo to gh workflow dispatch ([#12](https://github.com/crescendo-ops/host-chopin/issues/12)) ([52d4095](https://github.com/crescendo-ops/host-chopin/commit/52d409533b6255fc246fd88f969baa967e514862))
* **ci:** preserve multiline beta release notes via body_path ([#15](https://github.com/crescendo-ops/host-chopin/issues/15)) ([871241a](https://github.com/crescendo-ops/host-chopin/commit/871241ad22fa406a9c7792ae5690bb412d435809))
* **ci:** query open release PRs without gh search filter ([#9](https://github.com/crescendo-ops/host-chopin/issues/9)) ([2107e7d](https://github.com/crescendo-ops/host-chopin/commit/2107e7dbc6754e2f2825ac2f973b43a2338d07eb))
* **ci:** restore release-assets workflow dispatch for beta publish ([#27](https://github.com/crescendo-ops/host-chopin/issues/27)) ([f348d22](https://github.com/crescendo-ops/host-chopin/commit/f348d2263816be4dc944ce2f283e15f32874ff11))
* **ci:** use beta-v tags and allow manual release-asset dispatch ([#10](https://github.com/crescendo-ops/host-chopin/issues/10)) ([ecf6c1e](https://github.com/crescendo-ops/host-chopin/commit/ecf6c1e3e65557c90196d2a6d9f0b02c07a03c69))
* **ci:** use beta-vX.Y.Z-N and preserve release metadata on asset upload ([#14](https://github.com/crescendo-ops/host-chopin/issues/14)) ([e410c52](https://github.com/crescendo-ops/host-chopin/commit/e410c524d81d68ae2e8e90e40ee59febb13e92e4))
* **publish-beta:** escape jq regex in release PR lookup ([#26](https://github.com/crescendo-ops/host-chopin/issues/26)) ([a341db5](https://github.com/crescendo-ops/host-chopin/commit/a341db5fc3d05224514ae20d9a47cbbffeff2b46))


### Miscellaneous Chores

* **ci:** add release automation with semver beta prereleases ([#1](https://github.com/crescendo-ops/host-chopin/issues/1)) ([e11dd31](https://github.com/crescendo-ops/host-chopin/commit/e11dd3135d97f7e19390f745f7d1f3606fccb444))
* **ci:** configure release-please initial version 0.0.1 ([#21](https://github.com/crescendo-ops/host-chopin/issues/21)) ([410c675](https://github.com/crescendo-ops/host-chopin/commit/410c675d0b1e8ec004148b23d45dff4f6f94e0dc))
* **ci:** dedupe build steps and validate commit history ([#17](https://github.com/crescendo-ops/host-chopin/issues/17)) ([37232e9](https://github.com/crescendo-ops/host-chopin/commit/37232e98e6cbaeb93de39097c8b8192c51c9ad8d))
* **ci:** move beta publishing to manual workflow ([b34a983](https://github.com/crescendo-ops/host-chopin/commit/b34a983938b4a58eeca058a5aba493f0d4427e8c))
* **ci:** prefix release workflows and document release lint ([#28](https://github.com/crescendo-ops/host-chopin/issues/28)) ([a8350e2](https://github.com/crescendo-ops/host-chopin/commit/a8350e247057c449eea2364a2ab3081dd1574caf))
* **ci:** require scoped commit and PR title conventions ([c70c06e](https://github.com/crescendo-ops/host-chopin/commit/c70c06e6a11cded826d2b3ccda6c4aa2562aee95))
* **ci:** simplify workflows, add nix checks, and remove terraform devshell ([#19](https://github.com/crescendo-ops/host-chopin/issues/19)) ([f1500a9](https://github.com/crescendo-ops/host-chopin/commit/f1500a9c02310f78b3aafab5eeb91f74446ff547))
* **release:** align commit type rules with release headings ([#29](https://github.com/crescendo-ops/host-chopin/issues/29)) ([95ab2cf](https://github.com/crescendo-ops/host-chopin/commit/95ab2cf7a0088342f31776b229121c23167d38dd))
* **release:** include all commit types in release notes ([#30](https://github.com/crescendo-ops/host-chopin/issues/30)) ([b5650a7](https://github.com/crescendo-ops/host-chopin/commit/b5650a76040f07a916ed6d29e835682a1f2391c9))


### Code Refactoring

* **repo:** simplify host-chopin layout and docs ([#2](https://github.com/crescendo-ops/host-chopin/issues/2)) ([488622e](https://github.com/crescendo-ops/host-chopin/commit/488622ed7b225c842f1d73295424dedf6c7cb52e))


### Continuous Integration

* **release-assets:** version release asset name by tag ([e056935](https://github.com/crescendo-ops/host-chopin/commit/e056935b01234dd0fe32362e5585c9a8d975367a))
* **release:** unify beta prerelease flow with release-please ([#6](https://github.com/crescendo-ops/host-chopin/issues/6)) ([bf544af](https://github.com/crescendo-ops/host-chopin/commit/bf544af0a73f9db2d835f9ab6433e41a859a1ef4))
