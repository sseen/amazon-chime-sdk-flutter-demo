/*
 * Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
 * SPDX-License-Identifier: MIT-0
 */

class ApiConfig {
  // Format: https://<api-id>.execute-api.<aws-region-id>.amazonaws.com/Prod/
  static String get apiUrl => "https://miramed-chime-api.kenkohshien-dev.com/"; // API url goes here
  static String get region => "ap-northeast-1"; // Add region here
}
