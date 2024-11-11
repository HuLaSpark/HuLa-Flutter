import 'package:git_hooks/git_hooks.dart';

void main(List<String> arguments) {
  final Map<Git, UserBackFun> params = {
    Git.commitMsg: commitMsg,
  };
  GitHooks.call(arguments, params);
}

Future<bool> commitMsg() async {
  final commitMsg = await Utils.getCommitEditMsg();
  // 修改正则表达式，使冒号后的空格可选
  final pattern = RegExp(
    r'^(feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert):[ ]?.+',
  );

  if (pattern.hasMatch(commitMsg)) {
    return true;
  } else {
    print('\x1B[31m提交信息不符合规范！\x1B[0m');
    print('正确格式: type:subject 或 type: subject');
    print(
        'type 必须是以下之一: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert');
    print('示例: feat:添加登录功能');
    print('示例: fix: 修复token过期问题');
    return false;
  }
}
