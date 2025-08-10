<!-- Use this file to provide workspace-specific custom instructions to Copilot. For more details, visit https://code.visualstudio.com/docs/copilot/copilot-customization#_use-a-githubcopilotinstructionsmd-file -->

This repository contains infrastructure as code (Terraform) for a distributed serverless scraper on AWS (EventBridge, Lambda, SQS, DynamoDB, CloudWatch) and Lambda code examples in Node.js.

**Project structure:**

- Workflows: `.github/workflows/`
- Custom actions: `.github/actions/`
- Lambda source: `packages/`
- Lambda zips: `lambdas/`

Generate clean, modular code and always follow cloud and serverless best practices. Use composite actions for DRY build/zip logic. Reference the correct paths in all docs and code.
