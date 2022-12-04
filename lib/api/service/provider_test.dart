import 'dart:ui';

import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:image_picker/image_picker.dart';

List<Pair<User, Engineer>> usersTest = [
  Pair(
      first: User(
          isADM: true,
          isEnable: true,
          //isApproved: true,
          //dateApprove: "2022-01-01",
          cpf: "99999999999"),
      second: Engineer.test(
          id: 0,
          name: "Thiago Martins",
          isApproved: true,
          picture:
              "https://media-exp1.licdn.com/dms/image/C4D03AQHkQ_8ziYgIxA/profile-displayphoto-shrink_800_800/0/1605184152937?e=1675296000&v=beta&t=E5TQG5LkBYsHMt0KiYl4R5IyJWtbA2FVs5IwrTHNBAI")),
  Pair(
      first: User(isADM: false, isEnable: true, cpf: "11111111111"),
      second: Engineer.test(id: 1, name: "Felipe Roberto", isApproved: true)),
  Pair(
      first: User(isADM: false, isEnable: true, cpf: "22222222222"),
      second: Engineer.test(id: 2, name: "Gabriel Luan", isApproved: false)),
  Pair(
      first: User(isADM: false, isEnable: true, cpf: "33333333333"),
      second:
          Engineer.test(id: 3, name: "Raquel de Oliveira", isApproved: false)),
  Pair(
      first: User(isADM: false, isEnable: true, cpf: "44444444444"),
      second: Engineer.test(id: 4, name: "Ana Beatriz", isApproved: false)),
];

Map<int, XFile> usersImagesTest = {};
