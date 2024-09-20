-- | https://github.com/actions/setup-node
module Workflow.GitHub.Actions.Predefined.SetupNode
  ( Version (..),
    step,
    checkLatest,
    architecture,
    token,
    cache,
    cacheDependencyPath,
    registryUrl,
    scope,
    alwaysAuth,
  )
where

import Data.Aeson (ToJSON (toJSON))
import Data.Map qualified as M
import Workflow.GitHub.Actions qualified as GHA

data Version = AnyVersion | Version String | VersionFromFile String

step :: Version -> GHA.Step
step version = GHA.actionStep "actions/setup-node@v4" withArgs
  where
    withArgs = case version of
      AnyVersion -> mempty
      Version v -> M.singleton "node-version" $ toJSON v
      VersionFromFile f -> M.singleton "node-version-file" $ toJSON f

checkLatest :: Bool -> GHA.StepModifier
checkLatest = GHA.stepSetWithParam "check-latest"

architecture :: String -> GHA.StepModifier
architecture = GHA.stepSetWithParam "architecture"

token :: String -> GHA.StepModifier
token = GHA.stepSetWithParam "token"

cache :: String -> GHA.StepModifier
cache = GHA.stepSetWithParam "cache"

cacheDependencyPath :: String -> GHA.StepModifier
cacheDependencyPath = GHA.stepSetWithParam "cache-dependency-path"

registryUrl :: String -> GHA.StepModifier
registryUrl = GHA.stepSetWithParam "registry-url"

scope :: String -> GHA.StepModifier
scope = GHA.stepSetWithParam "scope"

alwaysAuth :: String -> GHA.StepModifier
alwaysAuth = GHA.stepSetWithParam "alwaysAuth"
