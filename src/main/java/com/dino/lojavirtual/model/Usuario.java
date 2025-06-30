package com.dino.lojavirtual.model;

import jakarta.persistence.*;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Objects;

@Entity
@Table(name = "usuario")
@SequenceGenerator(name = "seq_usuario", sequenceName = "seq_usuario", allocationSize = 1)
public class Usuario implements UserDetails {

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_usuario")
    private Long id;

    private String login;

    private String senha;

    @Temporal(TemporalType.DATE)
    private Date dataAtualSenha;

    @OneToMany(fetch = FetchType.LAZY)
    @JoinTable(
            name = "usuario_acesso",
            uniqueConstraints = @UniqueConstraint(columnNames = {"usuario_id", "acesso_id"}, name = "unique_acesso_user"),
            joinColumns =
                @JoinColumn(name = "usuario_id", referencedColumnName = "id", table = "usuario", foreignKey = @ForeignKey(name = "usuario_fk", value = ConstraintMode.CONSTRAINT)),
            inverseJoinColumns =
                @JoinColumn(name = "acesso_id", referencedColumnName = "id", table = "acesso", foreignKey = @ForeignKey(name = "acesso_fk", value = ConstraintMode.CONSTRAINT))
    )
    private List<Acesso> acessos;

    public Usuario(){}

    public Long getId() {
        return id;
    }

    public Date getDataAtualSenha() {
        return dataAtualSenha;
    }

    public void setDataAtualSenha(Date dataAtualSenha) {
        this.dataAtualSenha = dataAtualSenha;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return this.acessos;
    }

    @Override
    public String getPassword() {
        return this.senha;
    }

    @Override
    public String getUsername() {
        return this.login;
    }

    @Override
    public boolean equals(Object o) {
        if (o == null || getClass() != o.getClass()) return false;
        Usuario usuario = (Usuario) o;
        return Objects.equals(id, usuario.id);
    }

    @Override
    public int hashCode() {
        return Objects.hashCode(id);
    }
}
