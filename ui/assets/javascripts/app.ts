import angular = require("angular");
import {appName, externalModules} from "./constants";

angular.module(appName, externalModules);

import "./routes";
import "./resources/index";
import "./directives/index";
