# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "philly_frb_as_dataframe"
require "minitest/autorun"
require "webmock/minitest"
require "tempfile"

WebMock.disable_net_connect!
