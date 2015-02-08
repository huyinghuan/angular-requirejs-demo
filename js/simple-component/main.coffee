((define, require)->
  #定义主入口
  define 'SimpleComponent', ['angular'], (angular)->
    angular.module('simple.component', [])

  #加载其他组建
  define [
    './form/select'
  ], ()->

)(define, require)
