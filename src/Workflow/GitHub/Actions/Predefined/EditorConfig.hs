module Workflow.GitHub.Actions.Predefined.EditorConfig (step, alwaysLintAllFiles) where

import Workflow.GitHub.Actions qualified as GHA

step :: GHA.Step
step = GHA.actionStep "zbeekman/EditorConfig-Action@v1.1.1" mempty

alwaysLintAllFiles :: GHA.StepModifier
alwaysLintAllFiles = GHA.env "ALWAYS_LINT_ALL_FILES" "true"
