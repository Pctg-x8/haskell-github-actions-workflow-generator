module Workflow.GitHub.Actions.Predefined.Haskell.Setup (step, enableStack, stackSetupGHC) where

import Workflow.GitHub.Actions qualified as GHA

step :: GHA.Step
step = GHA.actionStep "haskell-actions/setup@v2" mempty

enableStack :: GHA.StepModifier
enableStack = GHA.stepSetWithParam "enable-stack" True

stackSetupGHC :: GHA.StepModifier
stackSetupGHC = GHA.stepSetWithParam "stack-setup-ghc" True
