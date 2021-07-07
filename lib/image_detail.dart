import 'package:flutter/material.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'dart:io';
import 'dart:ui';
import 'dart:async';

class DetailScreen extends StatefulWidget {
  final String imagePath;
  DetailScreen(this.imagePath);

  @override
  _DetailScreenState createState() => new _DetailScreenState(imagePath);
}

class _DetailScreenState extends State<DetailScreen> {
  _DetailScreenState(this.path);

  final String path;

  Size? _imageSize;
  String recognizedText = "Loading ...";
  String splitter = "XX";
  List campos = [];
  List camposFormulario = [];
  List redundNome = ["NOME","0ME","WOME","MOME"];
  List redundNasc = ["NASCIMEN","NASCTMEN","NASCLMEN"];
  List redundSexo = ["SEXO","SEX0"];
  List redundTel = ["TELEF","IELEF","IEIEF"];
  List redundCPF = ["CPF"];
  List redundEmail = ["EMAIL","EM4IL","EMATL","EMAII","EMATT","FM"];
  List redundEnd = ["ENDERE","ENBERE","EMDERE","EMBERE","ENDE RE","EN DERE"];
  List redundVac = ["VACINA","NACINA","VACTNA","VACLNA","NACTNA","VAC1NA","VACIWA"];
  List redundApl = ["APLICA","APLTCA","APLLCA","APIICA","APTTCA"];
  List redundLote = ["LOTE","L0TE","LOIE","L0IE","IOTE","I0TE","IOIE","I0IE"];
  List redundDose = ["DOSE","D0SE","BOSE","B0SE"];
  List processedText = [];

  void trocar(int indiceValor, String trocada, String substituta) { //Troca um char por outro ao longo de toda uma string str indexada por indiceValor em "campos"
    for (int i = 0; i < campos[indiceValor].length; i++) {
      if (campos[indiceValor][i] == trocada) 
        campos[indiceValor] = campos[indiceValor].substring(0,i) + substituta + campos[indiceValor].substring(i+1);
    }
  }

  void corrigirEndereco(int indiceValor) {
    List palavras = [];
    List prefixos = [];
    List posfixos = [];
    int indicePalavra = -1;
    List offset = [];
    bool preEncontrado = false;
    bool posEncontrado = false;
    String pre = "";
    String pos = "";
    int indicePre = 0; //indices do prefixo no valor
    int indicePos = 0; // indice do posfixo no valor
    
    
    palavras = ["APARTAMENTO",
                "AVENIDA",
                "CONDOMINIO"];

    prefixos = [["APA"],
                ["AVE"],
                ["COND","CON D","COMD","CO ND","CO MD", "CDND"]];

    posfixos = [["MENTO","MEMTO","MEMIO","MEN TO","MEM TO"],
                ["IDA","TDA"],
                ["MINIO","MTNIO","MTNTO","MI NIO","MT NIO","MT NTO"]];

    offset = [5,
              3,
              5
              ]; 
    


    for (int i = 0; i < palavras.length && !preEncontrado; i++) {
      posEncontrado = false;
      for (int j = 0; j < prefixos[i].length; j++) {
        if (campos[indiceValor].contains(prefixos[i][j])) {
          pre = prefixos[i][j];
          preEncontrado = true;
          indicePalavra = i;
        }
      }
      for (int j = 0; j < posfixos[i].length && !posEncontrado; j++) {
        if (campos[indiceValor].contains(posfixos[i][j])) {
          pos = posfixos[i][j];
          posEncontrado = true;
        }
      }
      if (pre != "" && pos != "") {
        indicePre = campos[indiceValor].indexOf(pre);
        indicePos = campos[indiceValor].lastIndexOf(pos) + offset[indicePalavra];
        campos[indiceValor] = campos[indiceValor].substring(0,indicePre) + palavras[indicePalavra] + campos[indiceValor].substring(indicePos);
      }
      preEncontrado = false;
      pre = "";
      pos = "";
    }
  }

  void corrigirVacina(int indiceValor) {
    List palavras = [];
    List prefixos = [];
    List posfixos = [];
    int indicePalavra = -1;
    List offset = [];
    bool preEncontrado = false;
    bool posEncontrado = false;
    String pre = "";
    String pos = "";
    int indicePre = 0; //indices do prefixo no valor
    int indicePos = 0; // indice do posfixo no valor
    
    palavras = ["CORONAVAC",
                "PFIZER",
                "JANSEN",
                "ASTRAZENECA"];
    prefixos = [["COR"],
                ["P"],
                ["JAN","UAN","JAM","UAM"],
                ["AST","ASI"]];
    posfixos = [["VAC"],
                ["ZER","ZFR"],
                ["SEN","SFM","SEM",'SFN'],
                ["ECA","FCA"]];
    offset = [3,
              3,
              3,
              3
              ]; 
    


    for (int i = 0; i < palavras.length && !preEncontrado; i++) {
      for (int j = 0; j < prefixos[i].length; j++) {
        if (campos[indiceValor].contains(prefixos[i][j])) {
          pre = prefixos[i][j];
          preEncontrado = true;
          indicePalavra = i;
        }
      }
      for (int j = 0; j < posfixos[i].length && !posEncontrado; j++) {
        if (campos[indiceValor].contains(posfixos[i][j])) {
          pos = posfixos[i][j];
          posEncontrado = true;
        }
      }
      if (pre != "" && pos != "") {
        indicePre = campos[indiceValor].indexOf(pre);
        indicePos = campos[indiceValor].lastIndexOf(pos) + offset[indicePalavra];
        campos[indiceValor] = campos[indiceValor].substring(0,indicePre) + palavras[indicePalavra] + campos[indiceValor].substring(indicePos);
      }
    }

  }

  void processarTexto(String texto) { 
    campos = texto.toUpperCase().split(splitter);
    print(campos);
    ajustarCampos(campos, "NOME");
    ajustarCampos(campos, "NASCIMENTO");
    ajustarCampos(campos, "SEXO");
    ajustarCampos(campos, "TELEFONE");
    ajustarCampos(campos, "CPF");
    ajustarCampos(campos, "EMAIL");
    ajustarCampos(campos, "ENDEREÇO");
    ajustarCampos(campos, "VACINA");
    ajustarCampos(campos, "APLICAÇÃO");
    ajustarCampos(campos, "LOTE");
    ajustarCampos(campos, "DOSE");
    print(camposFormulario);
  }

  void ajustarCampos(List campos, String tipo) {
    List redundancia = [];
    bool campoEncontrado = false;
    String valorCampo = "";
    int indiceValorCampo = 0;
    List campoAjustado = [];

    if (tipo == "NOME") redundancia = redundNome;
    if (tipo == "NASCIMENTO") redundancia = redundNasc;
    if (tipo == "SEXO") redundancia = redundSexo;
    if (tipo == "TELEFONE") redundancia = redundTel;
    if (tipo == "CPF") redundancia = redundCPF;
    if (tipo == "EMAIL") redundancia = redundEmail;
    if (tipo == "ENDEREÇO") redundancia = redundEnd;
    if (tipo == "VACINA") redundancia = redundVac;
    if (tipo == "APLICAÇÃO") redundancia = redundApl;
    if (tipo == "LOTE") redundancia = redundLote;
    if (tipo == "DOSE") redundancia = redundDose;

    //Distribuição nos valores nos campos corretos
    for (int i = 0; i < redundancia.length && !campoEncontrado; i++) { //para cada valor de redundancia
      for (int j = 0; j < campos.length && !campoEncontrado; j++) { //para cada valor da lista campos
        //print("j = ${j}, campos[${j}] = ${campos[j]}");
        if (campos[j].contains(redundancia[i])) {
         //print("i = $i, j = ${j}, campos[${j}] = ${campos[j]}, redundancia[$i] = ${redundancia[i]}");
          campoEncontrado = true;
          int k = j + 1;
          while ((campos[k] == "" || campos[k] == " ")) k++;
          indiceValorCampo = k;
        }
      }
    }

    // correcoes de possiveis erros
    if (tipo == "NOME" || tipo == "VACINA") {
      trocar(indiceValorCampo, "0", "O");
      trocar(indiceValorCampo, "6", "G");
      trocar(indiceValorCampo, "4", "H");
      trocar(indiceValorCampo, "4", "F");
      trocar(indiceValorCampo, "1", "I");
      trocar(indiceValorCampo, "2", "Z");
      trocar(indiceValorCampo, "5", "S");

    }
    if (tipo == "NASCIMENTO" || tipo == "TELEFONE" || tipo == "CPF" || tipo == "APLICAÇÃO") {
      trocar(indiceValorCampo, "O", "0");
      trocar(indiceValorCampo, "G", "6");
      trocar(indiceValorCampo, "H", "4");
      trocar(indiceValorCampo, "F", "4");
      trocar(indiceValorCampo, "I", "1");
      trocar(indiceValorCampo, "%", "8");
      trocar(indiceValorCampo, "Z", "2");
      trocar(indiceValorCampo, "S", "5");
      }

    if (tipo == "DOSE") {
      if (campos[indiceValorCampo] == "Z") campos[indiceValorCampo] = "2";
      if (campos[indiceValorCampo] == "7" || campos[indiceValorCampo] == "T" || campos[indiceValorCampo] == "L" || campos[indiceValorCampo] == "I")
        campos[indiceValorCampo] == "1";
    }

    if (tipo == "SEXO") {
      if (campos[indiceValorCampo] == "E" || campos[indiceValorCampo] == "4") campos[indiceValorCampo] = "F";
      else campos[indiceValorCampo] = "M";
    }
    if (tipo == "ENDEREÇO") {
      corrigirEndereco(indiceValorCampo);
    }
    if (tipo == "VACINA") {
      corrigirVacina(indiceValorCampo);
    }
  

    if (campoEncontrado) {
      campoAjustado = [tipo,campos[indiceValorCampo].trim()];
      camposFormulario.add(campoAjustado);
    }
  }


  void _initializeVision() async {
    //tODO: Initialize the text recognizer here

    //Retrieve the image file from the path, and call the _getImageSize() method:
    final File imageFile = File(path);
    if (imageFile != null) {
      await _getImageSize(imageFile);
    }

    //Create a FirebaseVisionImage object and a TextRecognizer object:
    final FirebaseVisionImage visionImage =
      FirebaseVisionImage.fromFile(imageFile);

    final TextRecognizer textRecognizer =
      FirebaseVision.instance.textRecognizer();

    //Retrieve the VisionText object by processing the visionImage:
    final VisionText visionText =
      await textRecognizer.processImage(visionImage);
    //Now, we have to retrieve the texts from the VisionText 
    //and then separate out the email addresses from it. The texts are present in blocks -> lines -> text.   
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$";
    RegExp regEx = RegExp(pattern);

    String mailAddress = "";
    String texto = "";

    for (TextBlock block in visionText.blocks) {
      /*for (TextLine line in block.lines) {
        // Checking if the line contains an email address
        /*if (regEx.hasMatch(line.text)) {
          mailAddress += line.text + '\n';
        }*/
      }*/
      texto += block.text + '\n';
    }
    //Store the retrieved text in the recognizedText variable.
    if (this.mounted) {
      setState(() {
        recognizedText = texto;
        processarTexto(recognizedText);
      });
    }
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    // Fetching image from path
    final Image image = Image.file(imageFile);

    // Retrieving its size
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;
    setState(() {
      _imageSize = imageSize;
    });
  }

  @override
  void initState() {
    _initializeVision();
    //processedText = recognizedText.split('XX');
    processarTexto(recognizedText);
    super.initState();
  }

  //Widget novo
  @override
  Widget build(BuildContext context) {
    Size tamanhoDispositivo = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Details"),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Container(
          height: tamanhoDispositivo.height * 0.8,
          width: tamanhoDispositivo.height * 0.8,
          padding: EdgeInsets.all(32),
          child: Column (
            children: [
              Text("Processando ficha..."),
              Text(recognizedText),
            ],
          )
        )
      ), 
    ); 
  }

  //Widget antigo
  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Details"),
      ),
      body: _imageSize != null
          ? Stack(
              children: <Widget>[
                Center(
                  child: Container(
                    width: double.maxFinite,
                    color: Colors.black,
                    child: AspectRatio(
                      aspectRatio: _imageSize!.aspectRatio,
                      child: Image.file(
                        File(path),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Card(
                    elevation: 8,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(
                              "Identified emails",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: 60,
                            child: SingleChildScrollView(
                              child: Text(
                                recognizedText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Container(
              color: Colors.black,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),
    );
  }*/
}