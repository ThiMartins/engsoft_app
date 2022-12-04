import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/formation.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/skills.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/engineer/engineer.dart';
import 'package:comunidade_de_engenheiros_de_software/api/model/user/user.dart';
import 'package:comunidade_de_engenheiros_de_software/util/global/pair.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  final List<Pair<User, Engineer>> usersTest = [
    Pair(
        first: User(
            isADM: true,
            isEnable: true,
            //isApproved: true,
            //dateApprove: "2022-01-01",
            cpf: "99999999999"),
        second: Engineer.test(name: "Thiago Martins")),
    Pair(
        first: User(
            isADM: false,
            isEnable: true,
            //isApproved: true,
            //picture:
            //"https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png",
            cpf: "11111111111"),
        second: Engineer.test(name: "Felipe Roberto")),
    Pair(
        first: User(
            isADM: false,
            isEnable: true,
            //isApproved: false,
            cpf: "22222222222"),
        second: Engineer.test(name: "Gabriel Luan")),
    Pair(
        first: User(
            isADM: false,
            isEnable: true,
            //isApproved: false,
            //dateApprove: "2022-01-01",
            cpf: "33333333333"),
        second: Engineer.test(name: "Raquel de Oliveira")),
    Pair(
        first: User(
            isADM: false,
            isEnable: false,
            //isApproved: false,
            cpf: "44444444444"),
        second: Engineer.test(name: "Ana Beatriz")),
    Pair(
      first: User(isADM: false, isEnable: false, cpf: "01234567890"),
      second: Engineer(
        id: 1,
        isApproved: true,
        //isEnable: true,
        nickname: "Zeca Urubu",
        birthday: "",
        cpf: "01234567890",
        address: "",
        phone: "",
        picture:
            "https://www.pngall.com/wp-content/uploads/5/Profile-PNG-High-Quality-Image.png",
        profile: "",
        formations: [Formation("Unigran", "01/01/2020", "28/11/2022")],
        experiences: [],
        projects: [],
        skills: [Skills("Inglês", "Basic")],
      ),
    )
  ];

  test("CPF deve ser 99999999999:", () {
    expect(usersTest[0].first.cpf, '99999999999');
  });

  test("CPF deve ser Thiago Martins:", () {
    expect(usersTest[0].second.nickname, 'Thiago Martins');
  });

  test("Teste X:", () {
    expect(usersTest[5].second.formations[0].institution, 'Unigran');
  });
}
