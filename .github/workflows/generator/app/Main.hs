module Main (main) where

import Control.Monad (forM_)
import Data.Aeson.Yaml (encode)
import Data.Bifunctor (Bifunctor (bimap))
import Data.ByteString.Lazy.Char8 qualified as LBS8
import Data.Function ((&))
import System.Environment (getArgs)
import System.FilePath ((</>))
import Workflow.GitHub.Actions qualified as GHA
import Workflow.GitHub.Actions.Predefined.Checkout qualified as Checkout
import Workflow.GitHub.Actions.Predefined.SetupEditorConfigChecker qualified as SetupEditorConfigChecker
import Workflow.GitHub.Actions.Predefined.Haskell.RunHlint qualified as RunHlint
import Workflow.GitHub.Actions.Predefined.Haskell.Setup qualified as SetupHaskell
import Workflow.GitHub.Actions.Predefined.Haskell.SetupHlint qualified as SetupHlint

job :: GHA.Job
job =
  GHA.namedAs "Lint and Test" $
    GHA.job
      [ GHA.namedAs "Checking out" $ Checkout.step Nothing,
        GHA.namedAs "Setup editorconfig-checker" SetupEditorConfigChecker.step,
        GHA.namedAs "Run editorconfig-checker" $ GHA.runStep "editorconfig-checker",
        GHA.namedAs "Setup hlint" SetupHlint.step,
        GHA.namedAs "Run hlint" $ RunHlint.step "./src" & RunHlint.failOn RunHlint.Warning,
        GHA.namedAs "Setup Haskell" $ SetupHaskell.step & SetupHaskell.enableStack & SetupHaskell.stackSetupGHC,
        GHA.namedAs "Run Test" $ GHA.runStep "stack test"
      ]

masterWorkflow :: GHA.Workflow
masterWorkflow =
  GHA.buildWorkflow [GHA.workflowJob "check" job] $
    GHA.onPush $
      GHA.workflowPushTrigger & GHA.filterBranch "master"

prWorkflow :: GHA.Workflow
prWorkflow =
  GHA.buildWorkflow [GHA.workflowJob "check" job] $
    GHA.onPullRequest $
      GHA.workflowPullRequestTrigger & GHA.filterType "opened" & GHA.filterType "synchronized"

targets :: [(String, GHA.Workflow)]
targets = [("check_master.yml", masterWorkflow), ("check_pr.yml", prWorkflow)]

main :: IO ()
main = do
  baseDir <- head <$> getArgs
  forM_ targets $ uncurry LBS8.writeFile . bimap (baseDir </>) encode
