module Workflow.GitHub.Actions.Predefined.SetupPNPM
  ( RunInstallOption (..),
    runInstallOption,
    runInstallWithArgs,
    runInstallGlobal,
    step,
  )
where

import Data.Aeson (ToJSON (toJSON), object, (.=))
import Data.Aeson.Yaml (encode)
import Data.ByteString.Lazy.UTF8 (toString)
import Data.List qualified as L
import Data.Map qualified as M
import Data.Maybe (catMaybes)
import Workflow.GitHub.Actions qualified as GHA
import Workflow.GitHub.Actions.InternalHelpers (maybeNonEmptyList)

data RunInstallOption = RunInstallOption
  { runInstallArgs :: [String],
    runInstallCwd :: Maybe String,
    runInstallRecursive :: Bool
  }

instance ToJSON RunInstallOption where
  toJSON RunInstallOption {..} =
    object $
      catMaybes
        [ ("args" .=) <$> maybeNonEmptyList runInstallArgs,
          ("cwd" .=) <$> runInstallCwd,
          ("recursive" .=) <$> if runInstallRecursive then Just runInstallRecursive else Nothing
        ]

instance GHA.DirectoryWorker RunInstallOption where
  workAt cwd opt = opt {runInstallCwd = Just cwd}

runInstallOption :: RunInstallOption
runInstallOption = RunInstallOption {runInstallArgs = [], runInstallCwd = Nothing, runInstallRecursive = False}

runInstallWithArgs :: [String] -> RunInstallOption
runInstallWithArgs args = runInstallOption {runInstallArgs = args}

runInstallGlobal :: RunInstallOption -> RunInstallOption
runInstallGlobal opts = opts {runInstallArgs = "--global" : runInstallArgs opts}

step :: [RunInstallOption] -> GHA.Step
step installOptions = GHA.actionStep "pnpm/action-setup@v2" args
  where
    args = maybe mempty (M.singleton "run_install" . toJSON) serializedInstallOptions
    serializedInstallOptions = if L.null installOptions then Nothing else Just $ toString $ encode installOptions
