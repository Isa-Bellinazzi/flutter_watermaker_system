class DataWatermakerEntity {
  String? titulo;
  String? subtitulo;
  String? dataCriacao;
  String? descricao;
  String? logradouro;
  String? precisao;
  String? latitude;
  String? longitude;
  String? autorDaFoto;
  String? observacao;

  DataWatermakerEntity(
      {this.autorDaFoto,
      this.dataCriacao,
      this.descricao,
      this.latitude,
      this.logradouro,
      this.longitude,
      this.observacao,
      this.precisao,
      this.subtitulo,
      this.titulo});
}
