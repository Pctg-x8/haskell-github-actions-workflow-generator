module Workflow.GitHub.Actions (module Exported, build) where

import Data.Aeson.Yaml (encode)
import Data.ByteString.Lazy (ByteString)
import Workflow.GitHub.Actions.CommonTraits as Exported
import Workflow.GitHub.Actions.Concurrency as Exported
import Workflow.GitHub.Actions.Environment as Exported
import Workflow.GitHub.Actions.ExpressionBuilder as Exported
import Workflow.GitHub.Actions.Job as Exported
import Workflow.GitHub.Actions.Permissions as Exported
import Workflow.GitHub.Actions.Step as Exported
import Workflow.GitHub.Actions.Strategy as Exported
import Workflow.GitHub.Actions.Workflow as Exported
import Workflow.GitHub.Actions.WorkflowTriggers as Exported

-- | build a workflow to single yaml file content
build :: Workflow -> ByteString
build = encode
