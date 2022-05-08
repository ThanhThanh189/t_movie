import 'package:flutter/material.dart';

class Contants {
  // static final seatA6 = [
  //   'A1',
  //   'B1',
  //   'C1',
  //   'D1',
  //   'A2',
  //   'B2',
  //   'C2',
  //   'D2',
  //   'A3',
  //   'B3',
  //   'C3',
  //   'D3',
  //   'A4',
  //   'B4',
  //   'C4',
  //   'D4',
  //   'A5',
  //   'B5',
  //   'C5',
  //   'D5',
  //   'A6',
  //   'B6',
  //   'C6',
  //   'D6',
  // ];

  // static final seatA12 = [
  //   'A7',
  //   'B7',
  //   'C7',
  //   'D7',
  //   'A8',
  //   'B8',
  //   'C8',
  //   'D8',
  //   'A9',
  //   'B9',
  //   'C9',
  //   'D9',
  //   'A10',
  //   'B10',
  //   'C10',
  //   'D10',
  //   'A11',
  //   'B11',
  //   'C11',
  //   'D11',
  //   'A12',
  //   'B12',
  //   'C12',
  //   'D12',
  // ];
  // static final seatA18 = [
  //   'A13',
  //   'B13',
  //   'C13',
  //   'D13',
  //   'A14',
  //   'B14',
  //   'C14',
  //   'D14',
  //   'A15',
  //   'B15',
  //   'C15',
  //   'D15',
  //   'A16',
  //   'B16',
  //   'C16',
  //   'D16',
  //   'A17',
  //   'B17',
  //   'C17',
  //   'D17',
  //   'A18',
  //   'B18',
  //   'C18',
  //   'D18',
  // ];
  // static final seatE4 = [
  //   'E1',
  //   'F1',
  //   'G1',
  //   'H1',
  //   'I1',
  //   'J1',
  //   'E2',
  //   'F2',
  //   'G2',
  //   'H2',
  //   'I2',
  //   'J2',
  //   'E3',
  //   'F3',
  //   'G3',
  //   'H3',
  //   'I3',
  //   'J3',
  //   'E4',
  //   'F4',
  //   'G4',
  //   'H4',
  //   'I4',
  //   'J4',
  // ];
  // static final seatE10 = [
  //   'E5',
  //   'F5',
  //   'G5',
  //   'H5',
  //   'I5',
  //   'J5',
  //   'E6',
  //   'F6',
  //   'G6',
  //   'H6',
  //   'I6',
  //   'J6',
  //   'E7',
  //   'F7',
  //   'G7',
  //   'H7',
  //   'I7',
  //   'J7',
  //   'E8',
  //   'F8',
  //   'G8',
  //   'H8',
  //   'I8',
  //   'J8',
  //   'E9',
  //   'F9',
  //   'G9',
  //   'H9',
  //   'I9',
  //   'J9',
  //   'E10',
  //   'F10',
  //   'G10',
  //   'H10',
  //   'I10',
  //   'J10',
  // ];
  // static final seatE14 = [
  //   'E11',
  //   'F11',
  //   'G11',
  //   'H11',
  //   'I11',
  //   'J11',
  //   'E12',
  //   'F12',
  //   'G12',
  //   'H12',
  //   'I12',
  //   'J12',
  //   'E13',
  //   'F13',
  //   'G13',
  //   'H13',
  //   'I13',
  //   'J13',
  //   'E14',
  //   'F14',
  //   'G14',
  //   'H14',
  //   'I14',
  //   'J14',
  // ];
}

extension ListToString on List<String> {
  String get title {
    var value = '';
    forEach(
      (element) {
        value += element + ',';
      },
    );
    return value.substring(0, value.length - 1);
  }
}

enum CinemaTime { t1, t2, t3, t4, t5, t6 }

extension CinemaTimeToString on CinemaTime {
  String get title {
    switch (this) {
      case CinemaTime.t1:
        return '12:20';
      case CinemaTime.t2:
        return '14:30';
      case CinemaTime.t3:
        return '16:30';
      case CinemaTime.t4:
        return '19:20';
      case CinemaTime.t5:
        return '21:30';
      case CinemaTime.t6:
        return '23:40';
    }
  }
}

enum CinemaName {
  centralParkCGV,
  fxSudirmanXXI,
  keapaGadingIMAX,
  vincomPlazaCGV,
}

extension CinemaNameToString on CinemaName {
  String get title {
    switch (this) {
      case CinemaName.centralParkCGV:
        return 'Central Park CGV';
      case CinemaName.fxSudirmanXXI:
        return 'FX Sudirman XXI';
      case CinemaName.keapaGadingIMAX:
        return 'Keapa Gading IMAX';
      case CinemaName.vincomPlazaCGV:
        return 'Vincom Plaza CGV';
    }
  }
}

enum SeatA6 {
  a1,
  b1,
  c1,
  d1,
  a2,
  b2,
  c2,
  d2,
  a3,
  b3,
  c3,
  d3,
  a4,
  b4,
  c4,
  d4,
  a5,
  b5,
  c5,
  d5,
  a6,
  b6,
  c6,
  d6,
}

extension SeatA6toString on SeatA6 {
  String get title {
    switch (this) {
      case SeatA6.a1:
        return 'A1';
      case SeatA6.b1:
        return 'B1';
      case SeatA6.c1:
        return 'C1';
      case SeatA6.d1:
        return 'D1';
      case SeatA6.a2:
        return 'A2';
      case SeatA6.b2:
        return 'B2';
      case SeatA6.c2:
        return 'C2';
      case SeatA6.d2:
        return 'D2';
      case SeatA6.a3:
        return 'A3';
      case SeatA6.b3:
        return 'B3';
      case SeatA6.c3:
        return 'C3';
      case SeatA6.d3:
        return 'D3';
      case SeatA6.a4:
        return 'A4';
      case SeatA6.b4:
        return 'B4';
      case SeatA6.c4:
        return 'C4';
      case SeatA6.d4:
        return 'D4';
      case SeatA6.a5:
        return 'A5';
      case SeatA6.b5:
        return 'B5';
      case SeatA6.c5:
        return 'C5';
      case SeatA6.d5:
        return 'D5';
      case SeatA6.a6:
        return 'A6';
      case SeatA6.b6:
        return 'B6';
      case SeatA6.c6:
        return 'C6';
      case SeatA6.d6:
        return 'D6';
    }
  }
}

enum SeatA12 {
  a7,
  b7,
  c7,
  d7,
  a8,
  b8,
  c8,
  d8,
  a9,
  b9,
  c9,
  d9,
  a10,
  b10,
  c10,
  d10,
  a11,
  b11,
  c11,
  d11,
  a12,
  b12,
  c12,
  d12,
}

extension SeatA12ToString on SeatA12 {
  String get title {
    switch (this) {
      case SeatA12.a7:
        return 'A7';
      case SeatA12.b7:
        return 'B7';
      case SeatA12.c7:
        return 'C7';
      case SeatA12.d7:
        return 'D7';
      case SeatA12.a8:
        return 'A8';
      case SeatA12.b8:
        return 'B8';
      case SeatA12.c8:
        return 'C8';
      case SeatA12.d8:
        return 'D8';
      case SeatA12.a9:
        return 'A9';
      case SeatA12.b9:
        return 'B9';
      case SeatA12.c9:
        return 'C9';
      case SeatA12.d9:
        return 'D9';
      case SeatA12.a10:
        return 'A10';
      case SeatA12.b10:
        return 'B10';
      case SeatA12.c10:
        return 'C10';
      case SeatA12.d10:
        return 'D10';
      case SeatA12.a11:
        return 'A11';
      case SeatA12.b11:
        return 'B11';
      case SeatA12.c11:
        return 'C11';
      case SeatA12.d11:
        return 'D11';
      case SeatA12.a12:
        return 'A12';
      case SeatA12.b12:
        return 'B12';
      case SeatA12.c12:
        return 'C12';
      case SeatA12.d12:
        return 'D12';
    }
  }
}

enum SeatA18 {
  a13,
  b13,
  c13,
  d13,
  a14,
  b14,
  c14,
  d14,
  a15,
  b15,
  c15,
  d15,
  a16,
  b16,
  c16,
  d16,
  a17,
  b17,
  c17,
  d17,
  a18,
  b18,
  c18,
  d18,
}

extension SeatA18ToString on SeatA18 {
  String get title {
    switch (this) {
      case SeatA18.a13:
        return 'A13';
      case SeatA18.b13:
        return 'B13';
      case SeatA18.c13:
        return 'C13';
      case SeatA18.d13:
        return 'D13';
      case SeatA18.a14:
        return 'A14';
      case SeatA18.b14:
        return 'B14';
      case SeatA18.c14:
        return 'C14';
      case SeatA18.d14:
        return 'D14';
      case SeatA18.a15:
        return 'A15';
      case SeatA18.b15:
        return 'B15';
      case SeatA18.c15:
        return 'C15';
      case SeatA18.d15:
        return 'D15';
      case SeatA18.a16:
        return 'A16';
      case SeatA18.b16:
        return 'B16';
      case SeatA18.c16:
        return 'C16';
      case SeatA18.d16:
        return 'D16';
      case SeatA18.a17:
        return 'A17';
      case SeatA18.b17:
        return 'B17';
      case SeatA18.c17:
        return 'C17';
      case SeatA18.d17:
        return 'D17';
      case SeatA18.a18:
        return 'A18';
      case SeatA18.b18:
        return 'B18';
      case SeatA18.c18:
        return 'C18';
      case SeatA18.d18:
        return 'D18';
    }
  }
}

enum SeatE4 {
  e1,
  f1,
  g1,
  h1,
  i1,
  j1,
  e2,
  f2,
  g2,
  h2,
  i2,
  j2,
  e3,
  f3,
  g3,
  h3,
  i3,
  j3,
  e4,
  f4,
  g4,
  h4,
  i4,
  j4,
}

extension SeatE4ToString on SeatE4 {
  String get title {
    switch (this) {
      case SeatE4.e1:
        return 'E1';
      case SeatE4.f1:
        return 'F1';
      case SeatE4.g1:
        return 'G1';
      case SeatE4.h1:
        return 'H1';
      case SeatE4.i1:
        return 'I1';
      case SeatE4.j1:
        return 'J1';
      case SeatE4.e2:
        return 'E2';
      case SeatE4.f2:
        return 'F2';
      case SeatE4.g2:
        return 'G2';
      case SeatE4.h2:
        return 'H2';
      case SeatE4.i2:
        return 'I2';
      case SeatE4.j2:
        return 'J2';
      case SeatE4.e3:
        return 'E3';
      case SeatE4.f3:
        return 'F3';
      case SeatE4.g3:
        return 'G3';
      case SeatE4.h3:
        return 'H3';
      case SeatE4.i3:
        return 'I3';
      case SeatE4.j3:
        return 'J3';
      case SeatE4.e4:
        return 'E4';
      case SeatE4.f4:
        return 'F4';
      case SeatE4.g4:
        return 'G4';
      case SeatE4.h4:
        return 'H4';
      case SeatE4.i4:
        return 'I4';
      case SeatE4.j4:
        return 'J4';
    }
  }
}

enum SeatE10 {
  e5,
  f5,
  g5,
  h5,
  i5,
  j5,
  e6,
  f6,
  g6,
  h6,
  i6,
  j6,
  e7,
  f7,
  g7,
  h7,
  i7,
  j7,
  e8,
  f8,
  g8,
  h8,
  i8,
  j8,
  e9,
  f9,
  g9,
  h9,
  i9,
  j9,
  e10,
  f10,
  g10,
  h10,
  i10,
  j10,
}

extension SeatE10ToString on SeatE10 {
  String get title {
    switch (this) {
      case SeatE10.e5:
        return 'E5';
      case SeatE10.f5:
        return 'F5';
      case SeatE10.g5:
        return 'G5';
      case SeatE10.h5:
        return 'H5';
      case SeatE10.i5:
        return 'I5';
      case SeatE10.j5:
        return 'J5';
      case SeatE10.e6:
        return 'E6';
      case SeatE10.f6:
        return 'F6';
      case SeatE10.g6:
        return 'G6';
      case SeatE10.h6:
        return 'H6';
      case SeatE10.i6:
        return 'I6';
      case SeatE10.j6:
        return 'J6';
      case SeatE10.e7:
        return 'E7';
      case SeatE10.f7:
        return 'F7';
      case SeatE10.g7:
        return 'G7';
      case SeatE10.h7:
        return 'H7';
      case SeatE10.i7:
        return 'I7';
      case SeatE10.j7:
        return 'J7';
      case SeatE10.e8:
        return 'E8';
      case SeatE10.f8:
        return 'F8';
      case SeatE10.g8:
        return 'G8';
      case SeatE10.h8:
        return 'H8';
      case SeatE10.i8:
        return 'I8';
      case SeatE10.j8:
        return 'J8';
      case SeatE10.e9:
        return 'E9';
      case SeatE10.f9:
        return 'F9';
      case SeatE10.g9:
        return 'G9';
      case SeatE10.h9:
        return 'H9';
      case SeatE10.i9:
        return 'I9';
      case SeatE10.j9:
        return 'J9';
      case SeatE10.e10:
        return 'E10';
      case SeatE10.f10:
        return 'F10';
      case SeatE10.g10:
        return 'G10';
      case SeatE10.h10:
        return 'H10';
      case SeatE10.i10:
        return 'I10';
      case SeatE10.j10:
        return 'J10';
    }
  }
}

enum SeatE14 {
  e11,
  f11,
  g11,
  h11,
  i11,
  j11,
  e12,
  f12,
  g12,
  h12,
  i12,
  j12,
  e13,
  f13,
  g13,
  h13,
  i13,
  j13,
  e14,
  f14,
  g14,
  h14,
  i14,
  j14,
}

extension SeatE14ToString on SeatE14 {
  String get title {
    switch (this) {
      case SeatE14.e11:
        return 'E11';
      case SeatE14.f11:
        return 'F11';
      case SeatE14.g11:
        return 'G11';
      case SeatE14.h11:
        return 'H11';
      case SeatE14.i11:
        return 'I11';
      case SeatE14.j11:
        return 'J11';
      case SeatE14.e12:
        return 'E12';
      case SeatE14.f12:
        return 'F12';
      case SeatE14.g12:
        return 'G12';
      case SeatE14.h12:
        return 'H12';
      case SeatE14.i12:
        return 'I12';
      case SeatE14.j12:
        return 'J12';
      case SeatE14.e13:
        return 'E13';
      case SeatE14.f13:
        return 'F13';
      case SeatE14.g13:
        return 'G13';
      case SeatE14.h13:
        return 'H13';
      case SeatE14.i13:
        return 'I13';
      case SeatE14.j13:
        return 'J13';
      case SeatE14.e14:
        return 'E14';
      case SeatE14.f14:
        return 'F14';
      case SeatE14.g14:
        return 'G14';
      case SeatE14.h14:
        return 'H14';
      case SeatE14.i14:
        return 'I14';
      case SeatE14.j14:
        return 'J14';
    }
  }
}

extension SeatToString on List<String> {
  String seatToString() {
    String listSeat = '';
    for (var item in this) {
      listSeat += item + ', ';
    }
    return listSeat.substring(0, listSeat.length - 2);
  }
}

extension ChooseTime on String {
  TimeOfDay get stringToTimeChoose {
    int hourChoose = int.parse(substring(0, 2));
    int minuteChoose = int.parse(substring(3));
    return TimeOfDay(hour: hourChoose, minute: minuteChoose);
  }
}

enum TopUpOption {
  topUp50000,
  topUp100000,
  topUp150000,
  topUp200000,
  topUp250000,
  topUp500000,
  topUp750000,
  topUp1000000,
}

extension TopUpBase on TopUpOption {
  String get topUpToString{
    switch (this) {
      case TopUpOption.topUp50000:
        return '50.000';
      case TopUpOption.topUp100000:
        return '100.000';
      case TopUpOption.topUp150000:
        return '150.000';
      case TopUpOption.topUp200000:
        return '200.000';
      case TopUpOption.topUp250000:
        return '250.000';
      case TopUpOption.topUp500000:
        return '500.000';
      case TopUpOption.topUp750000:
        return '750.000';
      case TopUpOption.topUp1000000:
        return '1.000.000';
    }
  }

  int get topUpToInt{
    switch (this) {
      case TopUpOption.topUp50000:
        return 50000;
      case TopUpOption.topUp100000:
        return 100000;
      case TopUpOption.topUp150000:
        return 150000;
      case TopUpOption.topUp200000:
        return 200000;
      case TopUpOption.topUp250000:
        return 250000;
      case TopUpOption.topUp500000:
        return 500000;
      case TopUpOption.topUp750000:
        return 750000;
      case TopUpOption.topUp1000000:
        return 1000000;
    }
  }
}
